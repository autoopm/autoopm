package org.ssssssss.magicboot.model;

import org.ssssssss.magicboot.utils.WebUtils;

public class UeditorConfig {

	private String imageActionName ="uploadImage";//执行上传图片的action名称 

	private String imageFieldName = "file";//提交的图片表单名称
	
	private long imageMaxSize = 2048000;//上传大小限制，单位B
	
	private String[] imageAllowFiles = new String[]{".png", ".jpg", ".jpeg", ".gif", ".bmp"};/* 上传图片格式显示 */
	
	private boolean imageCompressEnable = true;//是否压缩图片,默认是true
	
	private int imageCompressBorder = 1600;//图片压缩最长边限制
	
	private String imageInsertAlign = "none";//插入的图片浮动方式
	
	private String imageUrlPrefix = WebUtils.getUeditorPrefix();//图片访问路径前缀
	
	/* 上传保存路径,可以自定义保存路径和文件名格式 */
    /* {filename} 会替换成原文件名,配置这项需要注意中文乱码问题 */
    /* {rand:6} 会替换成随机数,后面的数字是随机数的位数 */
    /* {time} 会替换成时间戳 */
    /* {yyyy} 会替换成四位年份 */
    /* {yy} 会替换成两位年份 */
    /* {mm} 会替换成两位月份 */
    /* {dd} 会替换成两位日期 */
    /* {hh} 会替换成两位小时 */
    /* {ii} 会替换成两位分钟 */
    /* {ss} 会替换成两位秒 */
    /* 非法字符 \ : * ? " < > | */
    /* 具请体看线上文档: fex.baidu.com/ueditor/#use-format_upload_filename */
	private String imagePathFormat = "/ueditor/jsp/upload/image/{yyyy}{mm}{dd}/{time}{rand:6}";
	
	/*抓取远程图片配置*/
	private String catcherLocalDomain[] = new String[]{"127.0.0.1", "localhost", "img.baidu.com"};
	
	private String catcherActionName = "catchimage";/* 执行抓取远程图片的action名称 */
	
	private String catcherFieldName = "source";/* 提交的图片列表表单名称 */
	
	private String catcherPathFormat ="/ueditor/jsp/upload/image/{yyyy}{mm}{dd}/{time}{rand:6}"; /* 上传保存路径,可以自定义保存路径和文件名格式 */
	
	private long catcherMaxSize= 2048000; /* 上传大小限制，单位B */
	
	private String catcherAllowFiles[] = new String[]{".png", ".jpg", ".jpeg", ".gif", ".bmp"}; /* 抓取图片格式显示 */
	
	 /* 上传文件配置 */
	private String fileActionName = "uploadFile";
	
	private String fileFieldName =  "file"; /* 提交的文件表单名称 */
	
	private String filePathFormat = "/ueditor/jsp/upload/file/{yyyy}{mm}{dd}/{time}{rand:6}"; /* 上传保存路径,可以自定义保存路径和文件名格式 */
	
	private String fileUrlPrefix = WebUtils.getUeditorPrefix(); /* 文件访问路径前缀 */
	
	private long fileMaxSize = 51200000; /* 上传大小限制，单位B，默认50MB */
	
	 /* 上传文件格式显示 */
	private String[] fileAllowFiles = new String[]{".png", ".jpg", ".jpeg", ".gif", ".bmp",".flv", ".swf", ".mkv", ".avi", ".rm", ".rmvb", ".mpeg", ".mpg", ".ogg", ".ogv", ".mov", ".wmv", ".mp4",".mp3", ".wav", ".mid",".rar", ".zip", ".tar", ".gz", ".7z",".doc", ".docx", ".xls", ".xlsx", ".ppt", ".pptx", ".pdf", ".txt"};
	
	/* 列出指定目录下的图片 */
	private String imageManagerActionName = "listimage";/* 执行图片管理的action名称 */
	
	private String imageManagerListPath = "/upload/image/"; /* 指定要列出图片的目录 */
    
	private int imageManagerListSize =  20; /* 每次列出文件数量 */
    
	private String imageManagerUrlPrefix = WebUtils.getUeditorPrefix(); /* 图片访问路径前缀 */
    
	private String imageManagerInsertAlign = "none"; /* 插入的图片浮动方式 */
   
	private String[] imageManagerAllowFiles = new String[]{".png", ".jpg", ".jpeg", ".gif", ".bmp"}; /* 列出的文件类型 */
	
	/* 列出指定目录下的文件 */
	private String fileManagerActionName = "listfile";/* 执行文件管理的action名称 */
	
	private String fileManagerListPath =  "/upload/file/"; /* 指定要列出文件的目录 */
	
	private String fileManagerUrlPrefix = WebUtils.getUeditorPrefix(); /* 文件访问路径前缀 */
	
	private int fileManagerListSize =  20; /* 每次列出文件数量 */
	
	/* 列出的文件类型 */
	private String fileManagerAllowFiles[] = new String[]{".png", ".jpg", ".jpeg", ".gif", ".bmp",".flv", ".swf", ".mkv", ".avi", ".rm", ".rmvb", ".mpeg", ".mpg", ".ogg", ".ogv", ".mov", ".wmv", ".mp4",".mp3", ".wav", ".mid",".rar", ".zip", ".tar", ".gz", ".7z",".doc", ".docx", ".xls", ".xlsx", ".ppt", ".pptx", ".pdf", ".txt"};

	public String getImageActionName() {
		return imageActionName;
	}

	public void setImageActionName(String imageActionName) {
		this.imageActionName = imageActionName;
	}

	public String getImageFieldName() {
		return imageFieldName;
	}

	public void setImageFieldName(String imageFieldName) {
		this.imageFieldName = imageFieldName;
	}

	public long getImageMaxSize() {
		return imageMaxSize;
	}

	public void setImageMaxSize(long imageMaxSize) {
		this.imageMaxSize = imageMaxSize;
	}

	public String[] getImageAllowFiles() {
		return imageAllowFiles;
	}

	public void setImageAllowFiles(String[] imageAllowFiles) {
		this.imageAllowFiles = imageAllowFiles;
	}

	public boolean isImageCompressEnable() {
		return imageCompressEnable;
	}

	public void setImageCompressEnable(boolean imageCompressEnable) {
		this.imageCompressEnable = imageCompressEnable;
	}

	public int getImageCompressBorder() {
		return imageCompressBorder;
	}

	public void setImageCompressBorder(int imageCompressBorder) {
		this.imageCompressBorder = imageCompressBorder;
	}

	public String getImageInsertAlign() {
		return imageInsertAlign;
	}

	public void setImageInsertAlign(String imageInsertAlign) {
		this.imageInsertAlign = imageInsertAlign;
	}

	public String getImageUrlPrefix() {
		return imageUrlPrefix;
	}

	public void setImageUrlPrefix(String imageUrlPrefix) {
		this.imageUrlPrefix = imageUrlPrefix;
	}

	public String getImagePathFormat() {
		return imagePathFormat;
	}

	public void setImagePathFormat(String imagePathFormat) {
		this.imagePathFormat = imagePathFormat;
	}

	public String[] getCatcherLocalDomain() {
		return catcherLocalDomain;
	}

	public void setCatcherLocalDomain(String[] catcherLocalDomain) {
		this.catcherLocalDomain = catcherLocalDomain;
	}

	public String getCatcherActionName() {
		return catcherActionName;
	}

	public void setCatcherActionName(String catcherActionName) {
		this.catcherActionName = catcherActionName;
	}

	public String getCatcherFieldName() {
		return catcherFieldName;
	}

	public void setCatcherFieldName(String catcherFieldName) {
		this.catcherFieldName = catcherFieldName;
	}

	public String getCatcherPathFormat() {
		return catcherPathFormat;
	}

	public void setCatcherPathFormat(String catcherPathFormat) {
		this.catcherPathFormat = catcherPathFormat;
	}

	public long getCatcherMaxSize() {
		return catcherMaxSize;
	}

	public void setCatcherMaxSize(long catcherMaxSize) {
		this.catcherMaxSize = catcherMaxSize;
	}

	public String[] getCatcherAllowFiles() {
		return catcherAllowFiles;
	}

	public void setCatcherAllowFiles(String[] catcherAllowFiles) {
		this.catcherAllowFiles = catcherAllowFiles;
	}

	public String getFileActionName() {
		return fileActionName;
	}

	public void setFileActionName(String fileActionName) {
		this.fileActionName = fileActionName;
	}

	public String getFileFieldName() {
		return fileFieldName;
	}

	public void setFileFieldName(String fileFieldName) {
		this.fileFieldName = fileFieldName;
	}

	public String getFilePathFormat() {
		return filePathFormat;
	}

	public void setFilePathFormat(String filePathFormat) {
		this.filePathFormat = filePathFormat;
	}

	public String getFileUrlPrefix() {
		return fileUrlPrefix;
	}

	public void setFileUrlPrefix(String fileUrlPrefix) {
		this.fileUrlPrefix = fileUrlPrefix;
	}

	public long getFileMaxSize() {
		return fileMaxSize;
	}

	public void setFileMaxSize(long fileMaxSize) {
		this.fileMaxSize = fileMaxSize;
	}

	public String[] getFileAllowFiles() {
		return fileAllowFiles;
	}

	public void setFileAllowFiles(String[] fileAllowFiles) {
		this.fileAllowFiles = fileAllowFiles;
	}

	public String getImageManagerActionName() {
		return imageManagerActionName;
	}

	public void setImageManagerActionName(String imageManagerActionName) {
		this.imageManagerActionName = imageManagerActionName;
	}

	public String getImageManagerListPath() {
		return imageManagerListPath;
	}

	public void setImageManagerListPath(String imageManagerListPath) {
		this.imageManagerListPath = imageManagerListPath;
	}

	public int getImageManagerListSize() {
		return imageManagerListSize;
	}

	public void setImageManagerListSize(int imageManagerListSize) {
		this.imageManagerListSize = imageManagerListSize;
	}

	public String getImageManagerUrlPrefix() {
		return imageManagerUrlPrefix;
	}

	public void setImageManagerUrlPrefix(String imageManagerUrlPrefix) {
		this.imageManagerUrlPrefix = imageManagerUrlPrefix;
	}

	public String getImageManagerInsertAlign() {
		return imageManagerInsertAlign;
	}

	public void setImageManagerInsertAlign(String imageManagerInsertAlign) {
		this.imageManagerInsertAlign = imageManagerInsertAlign;
	}

	public String[] getImageManagerAllowFiles() {
		return imageManagerAllowFiles;
	}

	public void setImageManagerAllowFiles(String[] imageManagerAllowFiles) {
		this.imageManagerAllowFiles = imageManagerAllowFiles;
	}

	public String getFileManagerActionName() {
		return fileManagerActionName;
	}

	public void setFileManagerActionName(String fileManagerActionName) {
		this.fileManagerActionName = fileManagerActionName;
	}

	public String getFileManagerListPath() {
		return fileManagerListPath;
	}

	public void setFileManagerListPath(String fileManagerListPath) {
		this.fileManagerListPath = fileManagerListPath;
	}

	public String getFileManagerUrlPrefix() {
		return fileManagerUrlPrefix;
	}

	public void setFileManagerUrlPrefix(String fileManagerUrlPrefix) {
		this.fileManagerUrlPrefix = fileManagerUrlPrefix;
	}

	public int getFileManagerListSize() {
		return fileManagerListSize;
	}

	public void setFileManagerListSize(int fileManagerListSize) {
		this.fileManagerListSize = fileManagerListSize;
	}

	public String[] getFileManagerAllowFiles() {
		return fileManagerAllowFiles;
	}

	public void setFileManagerAllowFiles(String[] fileManagerAllowFiles) {
		this.fileManagerAllowFiles = fileManagerAllowFiles;
	}
	
	

}
