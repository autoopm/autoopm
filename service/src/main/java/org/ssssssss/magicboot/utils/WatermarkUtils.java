package org.ssssssss.magicboot.utils;

import com.itextpdf.text.DocumentException;
import com.itextpdf.text.Element;
import com.itextpdf.text.pdf.PdfContentByte;
import com.itextpdf.text.pdf.PdfWriter;
import org.apache.poi.xwpf.model.XWPFHeaderFooterPolicy;
import org.apache.poi.xwpf.usermodel.XWPFDocument;

import javax.swing.*;
import java.awt.*;
import java.io.*;
import java.nio.charset.StandardCharsets;

public class WatermarkUtils {

    public static void addWordWaterMark(String inputPath, String outPath, String markStr) {
        // 读取原始文件
        File inputFile = new File(inputPath);
        XWPFDocument doc = null;
        try {
            doc = new XWPFDocument(new FileInputStream(inputFile));
        } catch (FileNotFoundException var24) {
            throw new RuntimeException("源文件不存在");
        } catch (IOException var25) {
            throw new RuntimeException("读取源文件IO异常");
        } catch (Exception var26) {
            throw new RuntimeException("不支持的文档格式");
        }
        // 使用自带工具类完成水印填充
        XWPFHeaderFooterPolicy headerFooterPolicy = doc.getHeaderFooterPolicy();
        headerFooterPolicy.createWatermark(markStr);
        // 设置文档只读
        doc.enforceReadonlyProtection();
        // 生成输出文件
        File file = new File(outPath);
        if (!file.exists()) {
            try {
                file.createNewFile();
            } catch (IOException var23) {
                throw new RuntimeException("创建输出文件失败");
            }
        }
        // 打开输出流，将doc写入输出文件
        OutputStream os = null;
        try {
            os = new FileOutputStream(outPath);
            doc.write(os);
        } catch (FileNotFoundException var21) {
            throw new RuntimeException("创建输出文件失败");
        } catch (Exception var22) {
            throw new RuntimeException("添加文档水印失败");
        } finally {
            if (os != null) {
                try {
                    os.close();
                } catch (IOException var20) {
                    var20.printStackTrace();
                }
            }
        }
    }


    public static void addPDFWaterMark(String input, String output, String waterMarkName) {
        BufferedOutputStream bos = null;
        try {
            // 读取文件，生成reader
            com.itextpdf.text.pdf.PdfReader reader = new com.itextpdf.text.pdf.PdfReader(input);
            // 生成输出文件，开启输出流
            bos = new BufferedOutputStream(new FileOutputStream(new File(output)));
            // 读取输出流，生成stamper（印章）
            com.itextpdf.text.pdf.PdfStamper stamper = new com.itextpdf.text.pdf.PdfStamper(reader, bos);
            // 设置stamper加密
            stamper.setEncryption(null, "Ka_ze".getBytes(StandardCharsets.UTF_8), PdfWriter.ALLOW_PRINTING, PdfWriter.STANDARD_ENCRYPTION_128);

            // 获取总页数 +1, 下面从1开始遍历
            int total = reader.getNumberOfPages() + 1;
            // 使用classpath下面的字体库
            com.itextpdf.text.pdf.BaseFont base = null;
            try {
                base = com.itextpdf.text.pdf.BaseFont.createFont("STSong-Light", "UniGB-UCS2-H", com.itextpdf.text.pdf.BaseFont.EMBEDDED);
            } catch (Exception e) {
                // 日志处理
                e.printStackTrace();
            }
            // 间隔
            int interval = -15;
            // 获取水印文字的高度和宽度
            int textH = 0, textW = 0;
            JLabel label = new JLabel();
            label.setText(waterMarkName);
            FontMetrics metrics = label.getFontMetrics(label.getFont());
            textH = metrics.getHeight();
            textW = metrics.stringWidth(label.getText());

            // 设置水印透明度
            com.itextpdf.text.pdf.PdfGState gs = new com.itextpdf.text.pdf.PdfGState();
            gs.setFillOpacity(0.2f);
            gs.setStrokeOpacity(0.7f);

            com.itextpdf.text.Rectangle pageSizeWithRotation = null;
            PdfContentByte content = null;
            for (int i = 1; i < total; i++) {
                // 在内容上方加水印
                content = stamper.getOverContent(i);
                // 在内容下方加水印
                // content = stamper.getUnderContent(i);
                content.saveState();
                content.setGState(gs);

                // 设置字体和字体大小
                content.beginText();
                content.setFontAndSize(base, 20);

                // 获取每一页的高度、宽度
                pageSizeWithRotation = reader.getPageSizeWithRotation(i);
                float pageHeight = pageSizeWithRotation.getHeight();
                float pageWidth = pageSizeWithRotation.getWidth();

                // 根据纸张大小多次添加， 水印文字成30度角倾斜
                for (int height = interval + textH; height < pageHeight; height = height + textH * 6) {
                    for (int width = interval + textW; width < pageWidth + textW; width = width + textW * 2) {
                        content.showTextAligned(Element.ALIGN_LEFT, waterMarkName, width - textW, height - textH, 30);
                    }
                }
                content.endText();
            }

            // 关流
            stamper.close();
            reader.close();
        } catch (DocumentException | IOException e) {
            e.printStackTrace();
        }
    }






}
