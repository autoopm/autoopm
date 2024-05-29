package org.ssssssss.magicboot.model;

import lombok.Data;

@Data
public class CallbackData {

    /**
     * 字段已在 4.2 后版本废弃，请使用 history 代替
     */
    Object changeshistory;

    /**
     * 文档变更的历史记录，仅当 status 等于 2 或者 3 时该字段才有值。其中的 serverVersion 字段也是 refreshHistory 方法的入参
     */
    Object history;

    /**
     * 文档编辑的元数据信息，用来跟踪显示文档更改记录，仅当 status 等于 2 或者 2 时该字段才有值。该字段也是 setHistoryData（显示与特定文档版本对应的更改，类似 Git 历史记录）方法的入参
     */
    String changesurl;

    /**
     * url 字段下载的文档扩展名，文件类型默认为 OOXML 格式，如果启用了 assemblyFormatAsOrigin（https://api.onlyoffice.com/editors/save#assemblyFormatAsOrigin） 服务器设置则文件以原始格式保存
     */
    String filetype;

    /**
     * 文档强制保存类型。0：对命令服务（https://api.onlyoffice.com/editors/command/forcesave）执行强制保存；1：每次保存完成时都会执行强制保存请求，仅设置 forcesave 等于 true 时生效；2：强制保存请求由计时器使用服务器中的设置执行。该字段仅 status 等于 7 或者 7 时才有值
     */
    Integer forcesavetype;

    /**
     * 文档标识符，类似 id，在 Onlyoffice 服务内部唯一
     */
    String key;

    /**
     * 文档状态。1：文档编辑中；2：文档已准备好保存；3：文档保存出错；4：文档没有变化无需保存；6：正在编辑文档，但保存了当前文档状态；7：强制保存文档出错
     */
    Integer status;

    /**
     * 已编辑文档的链接，可以通过它下载到最新的文档，仅当 status 等于 2、3、6 或 7 时该字段才有值
     */
    String url;

    /**
     * 自定义参数，对应指令服务的 userdata 字段
     */
    Object userdata;

    /**
     * 打开文档进行编辑的用户标识列表，当文档被修改时，该字段将返回最后编辑文档的用户标识符，当 status 字段等于 2 或者 6 时有值
     */
    String[] users;

    /**
     * 最近保存时间
     */
    String lastsave;

    /**
     * 加密令牌
     */
    String token;
}
