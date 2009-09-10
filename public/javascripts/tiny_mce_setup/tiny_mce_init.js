 // tinyMCE.init({
 //                mode : "textareas",
 //                theme : "advanced",
 //                plugins : "emotions,iespell",
 //                theme_advanced_buttons2_add : "zoom,separator,forecolor,backcolor,liststyle",
 //                theme_advanced_buttons2_add_before: "search,replace,separator",
 //                theme_advanced_buttons2_add : "emotions,iespell,fullscreen",
 //           
 // 
 // 		theme_advanced_toolbar_location : "top",
 //                theme_advanced_toolbar_align : "left",
 //                theme_advanced_statusbar_location : "bottom",
 //                extended_valid_elements : "hr[class|width|size|noshade]",
 //                paste_use_dialog : false,
 //                theme_advanced_resizing : false,
 //                theme_advanced_resize_horizontal : false,
 //                apply_source_formatting : true
 //        });


tinyMCE.init({
	mode : "textareas",
	theme : "advanced",
	plugins : "emotions,iespell,youtube",
	theme_advanced_buttons1 : "bold,italic,underline,separator,strikethrough,justifyleft,justifycenter,justifyright, justifyfull,bullist,numlist,undo,redo,link,unlink,iespell,|,code,cleanup,|,forecolor,backcolor,youtube",
	theme_advanced_buttons2 : "",
	theme_advanced_buttons3 : "",
	theme_advanced_toolbar_location : "top",
	theme_advanced_toolbar_align : "left",
	theme_advanced_statusbar_location : "bottom",
	//extended_valid_elements : "a[name|href|target|title|onclick],img[class|src|border=0|alt|title|hspace|vspace|width|height|align|onmouseover|onmouseout|name],hr[class|width|size|noshade],font[face|size|color|style],span[class|align|style]"
	apply_source_formatting : false
});
