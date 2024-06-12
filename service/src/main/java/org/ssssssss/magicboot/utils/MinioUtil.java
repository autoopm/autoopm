package org.ssssssss.magicboot.utils;

import cn.hutool.core.codec.Base64;
import cn.hutool.core.date.DateUtil;
import cn.hutool.core.io.IoUtil;
import cn.hutool.core.util.IdUtil;
import cn.hutool.core.util.StrUtil;
import io.minio.*;
import io.minio.errors.MinioException;
import io.minio.http.Method;
import io.minio.messages.Bucket;
import io.minio.messages.Item;
import jakarta.annotation.Resource;
import jakarta.servlet.ServletOutputStream;
import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;
import org.springframework.util.FastByteArrayOutputStream;
import org.springframework.web.multipart.MultipartFile;
import org.ssssssss.magicapi.core.servlet.MagicHttpServletResponse;
import org.ssssssss.magicboot.configuration.MinioConfig;

import java.io.*;
import java.net.URLEncoder;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

@Component
@Slf4j
@RequiredArgsConstructor
public class MinioUtil {

    @Autowired
    private MinioConfig prop;

    @Resource
    private MinioClient minioClient;

    /**
     * 查看存储bucket是否存在
     *
     * @return boolean
     */
    public Boolean bucketExists(String bucketName) {
        Boolean found;
        try {
            found = minioClient.bucketExists(BucketExistsArgs.builder().bucket(bucketName).build());
        } catch (Exception e) {
            log.error(e.getMessage(), e);
            return false;
        }
        return found;
    }

    /**
     * 创建存储bucket
     *
     * @return Boolean
     */
    public Boolean makeBucket(String bucketName) {
        try {
            minioClient.makeBucket(MakeBucketArgs.builder()
                    .bucket(bucketName)
                    .build());
        } catch (Exception e) {
            log.error(e.getMessage(), e);
            return false;
        }
        return true;
    }

    /**
     * 检查桶是否存在，不存在则创建
     * @param bucketName
     */
    public void checkBucket(String bucketName){
        if (bucketExists(bucketName)) {
            log.info("Bucket already exists.");
        } else {
            // 创建一个名为task的存储桶
            makeBucket(bucketName);
            log.info("create a new bucket.");
        }
    }

    /**
     * 删除存储bucket
     *
     * @return Boolean
     */
    public Boolean removeBucket(String bucketName) {
        try {
            minioClient.removeBucket(RemoveBucketArgs.builder()
                    .bucket(bucketName)
                    .build());
        } catch (Exception e) {
            log.error(e.getMessage(), e);
            return false;
        }
        return true;
    }

    /**
     * 获取全部bucket
     */
    public List<Bucket> getAllBuckets() {
        try {
            List<Bucket> buckets = minioClient.listBuckets();
            return buckets;
        } catch (Exception e) {
            log.error(e.getMessage(), e);
        }
        return null;
    }

    /**
     * 将base64字符串的存储到minio中
     *
     * @param str base64字符串
     * @return
     */
    public String uploadBase64(String str) {
        checkBucket(prop.getBucketName());
        byte[] imageBytes = Base64.decode(str);
        String fileName = IdUtil.simpleUUID();
        String objectName = DateUtil.today() + "/" + fileName + ".jpeg";

        try {
            PutObjectArgs objectArgs = PutObjectArgs.builder()
                    .bucket(prop.getBucketName())
                    .object(objectName)
                    .stream(new ByteArrayInputStream(imageBytes), imageBytes.length, -1)
                    .contentType("image/jpeg")
                    .build();
            minioClient.putObject(objectArgs);

        } catch (Exception e) {
            log.error(e.getMessage(), e);
            return null;
        }
        return objectName;

    }

    /**
     * 保存文本内容
     *
     * @param str 文本文档
     * @return
     */
    public String uploadTxt(String str) {
        checkBucket(prop.getBucketName());
        String fileName = IdUtil.simpleUUID();
        String objectName = DateUtil.today() + "/" + fileName + ".txt";

        ByteArrayInputStream bais = new ByteArrayInputStream(str.getBytes());

        try {
            PutObjectArgs objectArgs = PutObjectArgs.builder()
                    .bucket(prop.getBucketName())
                    .object(objectName)
                    .stream(bais, bais.available(), -1)
                    .contentType("text/plain")
                    .build();
            minioClient.putObject(objectArgs);

        } catch (Exception e) {
            log.error(e.getMessage(), e);
            return null;
        }
        return objectName;
    }

    /**
     * 获取某个url文件的内容（这里都是txt文件）
     *
     * @param objectName 资源名称
     * @return
     */
    public String getContent(String objectName) {
        try {
            GetObjectArgs args = GetObjectArgs.builder()
                    .bucket(prop.getBucketName())
                    .object(objectName)
                    .build();
            BufferedReader reader = new BufferedReader(new InputStreamReader(minioClient.getObject(args)));
            StringBuilder content = new StringBuilder();
            String line;
            while ((line = reader.readLine()) != null) {
                content.append(line).append("\n");
            }
            reader.close();
            return content.toString();
        } catch (Exception e) {
            log.error(e.getMessage(), e);
        }
        return "";

    }


    /**
     * 文件上传
     *
     * @param file 文件
     * @return Boolean
     */
    public String upload(MultipartFile file) {
        checkBucket(prop.getBucketName());
        String originalFilename = file.getOriginalFilename();
        if (StrUtil.isBlank(originalFilename)) {
            throw new RuntimeException();
        }
        String fileName = IdUtil.simpleUUID() + originalFilename.substring(originalFilename.lastIndexOf("."));
        String objectName = DateUtil.today() + "/" + fileName;
        try {
            PutObjectArgs objectArgs = PutObjectArgs.builder().bucket(prop.getBucketName()).object(objectName)
                    .stream(file.getInputStream(), file.getSize(), -1).contentType(file.getContentType()).build();
            //文件名称相同会覆盖
            minioClient.putObject(objectArgs);
        } catch (Exception e) {
            log.error(e.getMessage(), e);
            return null;
        }
        return objectName;
    }

    /**
     * 预览图片
     *
     * @param fileName
     * @return
     */
    public String preview(String fileName) {
        // 查看文件地址
        GetPresignedObjectUrlArgs build = new GetPresignedObjectUrlArgs().builder().bucket(prop.getBucketName()).object(fileName).method(Method.GET).build();
        try {
            String url = minioClient.getPresignedObjectUrl(build);
            return url;
        } catch (Exception e) {
            log.error(e.getMessage(), e);
        }
        return null;
    }

    /**
     * 文件下载
     *
     * @param fileName 文件名称
     * @param res      response
     * @return Boolean
     */
    public void download(String fileName, HttpServletResponse res) {
        GetObjectArgs objectArgs = GetObjectArgs.builder().bucket(prop.getBucketName())
                .object(fileName).build();
        try (GetObjectResponse response = minioClient.getObject(objectArgs)) {
            byte[] buf = new byte[1024];
            int len;
            try (FastByteArrayOutputStream os = new FastByteArrayOutputStream()) {
                while ((len = response.read(buf)) != -1) {
                    os.write(buf, 0, len);
                }
                os.flush();
                byte[] bytes = os.toByteArray();
                res.setCharacterEncoding("utf-8");
                // 设置强制下载不打开
                // res.setContentType("application/force-download");
                res.addHeader("Content-Disposition", "attachment;fileName=" + fileName);
                try (ServletOutputStream stream = res.getOutputStream()) {
                    stream.write(bytes);
                    stream.flush();
                }
            }
        } catch (Exception e) {
            log.error(e.getMessage(), e);
        }
    }

    public byte[] download(String fileName) {
        GetObjectArgs objectArgs = GetObjectArgs.builder().bucket(prop.getBucketName())
                .object(fileName).build();
        try (GetObjectResponse response = minioClient.getObject(objectArgs)) {
            byte[] buf = new byte[1024];
            int len;
            try (FastByteArrayOutputStream os = new FastByteArrayOutputStream()) {
                while ((len = response.read(buf)) != -1) {
                    os.write(buf, 0, len);
                }
                os.flush();
                byte[] bytes = os.toByteArray();
                return bytes;
            }
        } catch (Exception e) {
            log.error(e.getMessage(), e);
        }
        return null;
    }

    /**
     * 查看文件对象
     *
     * @return 存储bucket内文件对象信息
     */
    public List<Item> listObjects() {
        Iterable<Result<Item>> results = minioClient.listObjects(
                ListObjectsArgs.builder().bucket(prop.getBucketName()).build());
        List<Item> items = new ArrayList<>();
        try {
            for (Result<Item> result : results) {
                items.add(result.get());
            }
        } catch (Exception e) {
            log.error(e.getMessage(), e);
            return null;
        }
        return items;
    }

    /**
     * 删除
     *
     * @param fileName
     * @return
     * @throws Exception
     */
    public boolean remove(String fileName) {
        try {
            minioClient.removeObject(RemoveObjectArgs.builder().bucket(prop.getBucketName()).object(fileName).build());
        } catch (Exception e) {
            log.error(e.getMessage(), e);
            return false;
        }
        return true;
    }




    /**
     * 文件上传
     *
     * @param stream
     * @param fileName
     * @return
     * @throws Exception
     */
    public String uploadStream(InputStream stream, String fileName) {
        checkBucket(prop.getBucketName());
        String newFileName = IdUtil.simpleUUID() + fileName.substring(fileName.lastIndexOf("."));
        String objectName = DateUtil.today() + "/" + newFileName;
        PutObjectArgs objectArgs = null;
        try {
            objectArgs = PutObjectArgs.builder().object(objectName)
                    .bucket(prop.getBucketName())
                    .contentType("application/octet-stream")
                    .stream(stream, stream.available(), -1).build();
            minioClient.putObject(objectArgs);
        } catch (Exception e) {
            log.error(e.getMessage(), e);
            return "";
        }

        return objectName;
    }

    /**
     * 获取文件流
     *
     * @param bucketName
     * @param objectName
     * @return
     */
    public InputStream getMinioFile(String bucketName, String objectName) {
        InputStream inputStream = null;
        try {
            GetObjectArgs objectArgs = GetObjectArgs.builder().object(objectName)
                    .bucket(bucketName).build();
            inputStream = minioClient.getObject(objectArgs);
        } catch (Exception e) {
            log.info("文件获取失败" + e.getMessage());
        }
        return inputStream;
    }

    /**
     * 预览文件
     *
     * @param fileName   文件名称
     * @param objectName minio中的路径
     * @return
     */
    public void previewfile(String objectName, String fileName, OutputStream outputStream) {
        InputStream inputStream = null;
        try {
            inputStream = getMinioFile(prop.getBucketName(), objectName);
            IoUtil.copy(inputStream, outputStream, IoUtil.DEFAULT_BUFFER_SIZE);
        } catch (Exception e) {
            log.error("预览文件失败" + e.getMessage());
        } finally {
            if (inputStream != null) {
                try {
                    inputStream.close();
                } catch (IOException e) {
                    log.error(e.getMessage(), e);
                }
            }
            if (outputStream != null) {
                try {
                    outputStream.close();
                } catch (IOException e) {
                    log.error(e.getMessage(), e);
                }
            }
        }

    }


    /**
     * 复制对象
     * @param oldObjName 旧的文件名称
     * @param newObjName 新的文件名称
     */
    public void copyObject(String oldObjName,String newObjName){
        try{
            minioClient.copyObject(
                    CopyObjectArgs.builder()
                            .source(CopySource.builder()
                                    .bucket(prop.getBucketName())
                                    .object(oldObjName)
                                    .build())
                            .bucket(prop.getBucketName())
                            .object(newObjName)
                            .build());

        }catch (Exception e){
            e.printStackTrace();
        }
    }

    public boolean isObjectExists(String objectName) {
        try{
            GetObjectArgs args = GetObjectArgs.builder()
                    .bucket(prop.getBucketName())
                    .object(objectName)
                    .build();
            minioClient.getObject(args);
            return true;
        }catch (MinioException | IOException e ){
            if (e.getMessage().contains("NoSuchKey")) {  //如果对象不存在，则会抛出NoSuchKeyException
                return false;
            }
            return false;
        } catch (NoSuchAlgorithmException | InvalidKeyException e) {
            return false;
        }
    }

}
