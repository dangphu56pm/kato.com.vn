CKEDITOR.editorConfig = function( config ) {
	config.extraPlugins = 'wordcount,notification,dialogadvtab,youtube';
	config.wordcount = {
    // Whether or not you want to show the Paragraphs Count
    showParagraphs: true,
    // Whether or not you want to show the Word Count
    showWordCount: true,
    // Whether or not you want to show the Char Count
    showCharCount: true,
    // Whether or not you want to count Spaces as Chars
    countSpacesAsChars: false,
    // Whether or not to include Html chars in the Char Count
    countHTML: false,
    // Maximum allowed Word Count, -1 is default for unlimited
    maxWordCount: -1,
    // Maximum allowed Char Count, -1 is default for unlimited
    maxCharCount: -1
	};
	config.toolbarGroups = [
		{ name: 'clipboard',   groups: [ 'clipboard', 'undo' ] },
//                { name: 'insert', items: ['Image', 'Youtube']},
		{ name: 'editing',     groups: [ 'find', 'selection', 'spellchecker' ] },
		{ name: 'links' },
		{ name: 'insert' },
		{ name: 'forms' },
		{ name: 'tools' },
		{ name: 'document',	   groups: [ 'mode', 'document', 'doctools' ] },
		{ name: 'others' },
		'/',
		{ name: 'basicstyles', groups: [ 'basicstyles', 'cleanup' ] },
		{ name: 'paragraph',   groups: [ 'list', 'indent', 'code','blocks', 'align', 'bidi' ] },
		{ name: 'styles' },
		{ name: 'colors' }
	];
	config.allowedContent = true;
	config.extraAllowedContent = '*(*)';
	config.removeButtons = 'Underline,Subscript,Superscript';
	config.format_tags = 'p;h1;h2;h3;h4;h5;pre';
	//config.removeDialogTabs = 'link:target;link:advanced;image:Link;image:advanced';
	//config.removeDialogTabs = 'image:advanced;link:advanced;';
	config.entities = false;
};