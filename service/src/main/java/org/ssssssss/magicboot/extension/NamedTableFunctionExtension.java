package org.ssssssss.magicboot.extension;

import org.springframework.stereotype.Component;
import org.ssssssss.magicapi.modules.db.table.NamedTable;
import org.ssssssss.magicboot.model.MagicBootConstants;
import org.ssssssss.script.annotation.Comment;
import org.ssssssss.script.functions.ExtensionMethod;
import org.ssssssss.script.runtime.RuntimeContext;

import java.util.Map;

@Component
public class NamedTableFunctionExtension implements ExtensionMethod {

    @Override
    public Class<?> support() {
        return NamedTable.class;
    }

    @Comment("保存到表中，当主键有值时则修改，否则插入")
    public static Object saveOrUpdate(NamedTable namedTable, RuntimeContext runtimeContext, @Comment("各项列和值") Map<String, Object> data){
        namedTable.setAttribute(MagicBootConstants.COMMON_FIELD, true);
        namedTable.save(runtimeContext, data,true);
        return namedTable.getAttribute(MagicBootConstants.ID);
    }

    @Comment("保存到表中，当主键有值时则修改，否则插入")
    public static Object saveOrUpdate(NamedTable namedTable, RuntimeContext runtimeContext){
        return saveOrUpdate(namedTable, runtimeContext, null);
    }

}
