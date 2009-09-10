// InPlaceRichEditor, version 1.2_rc1
// 
// Author: Sebastien Grosjean (http://www.zencocoon.com, http://seb.box.re)
//
// Contributor:
//   Neil Rickards, Robert Muzslai, Andrew Petersen, Brian Hansen, Brian French,
//   Dan Dalf, Anton Mostovoy, Hans-Peter
//
// InPlaceRichEditor is freely distributable under the terms of an MIT-style license.
// For details, see the inPlaceRichEditor web site: http://inplacericheditor.box.re/

if(typeof Ajax.InPlaceEditor == 'undefined')
  throw("InPlaceRichEditor requires including script.aculo.us' controls.js library");
if(typeof tinyMCE == 'undefined')
  throw("InPlaceRichEditor requires including moxiecode' tiny_mce.js library and proper initialization");

Ajax.InPlaceRichEditor = Class.create(Ajax.InPlaceEditor, {
  // Dump form InPlaceEditor with only few changes
  // * Add support of formIdSuffix option
  // * Deletion of the Deprecation layer
  // * Add tinymce initialization
  initialize: function(element, url, options) {
	this.tinymce = tinyMCE;
    this.url = url;
    this.element = element = $(element);
    this.prepareOptions();
    this._controls = { };
    // Removed :: arguments.callee.dealWithDeprecatedOptions(options); // DEPRECATION LAYER!!!
    Object.extend(this.options, options || { });
    if (!this.options.formId && this.element.id) {
      this.options.formId = this.element.id + '-' + this.options.formIdSuffix;
      if ($(this.options.formId))
        this.options.formId = '';
    }
    if (this.options.externalControl)
      this.options.externalControl = $(this.options.externalControl);
    if (!this.options.externalControl)
      this.options.externalControlOnly = false;
    this._originalBackground = this.element.getStyle('background-color') || 'transparent';
    this.element.title = this.options.clickToEditText;
    this._boundCancelHandler = this.handleFormCancellation.bind(this);
    this._boundComplete = (this.options.onComplete || Prototype.emptyFunction).bind(this);
    this._boundFailureHandler = this.handleAJAXFailure.bind(this);
    this._boundSubmitHandler = this.handleFormSubmission.bind(this);
    this._boundWrapperHandler = this.wrapUp.bind(this);
    this.registerListeners();
  },
  createEditField: function() {
    var text = (this.options.loadTextURL ? this.options.loadingText : this.getText());
    var fld;
    fld = document.createElement('textarea');
    fld.id = this.element.id + '-' + this.options.textareaIdSuffix;
    fld.rows = myRows;
    fld.cols = myCols;
    fld.name = this.options.paramName;
    fld.value = text; // No HTML breaks conversion anymore
    fld.className = this.options.editorClassName;
	// TODO: Check if onBlur can be supported
    // if (this.options.submitOnBlur)
    //   fld.onblur = this._boundSubmitHandler;
    this._controls.editor = fld;
    if (this.options.loadTextURL)
      this.loadExternalText();
    this._form.appendChild(this._controls.editor);
  },
  enterEditMode: function($super, e) {
	$super(e);
	this.tinymce.execCommand('mceAddControl', false, this._controls.editor.id);
  },
  handleAJAXFailure: function($super, transport) {
    $super();
	// TODO: Replace when upgrading to tinyMCE 3.0
	// this.tinymce.get(this._controls.editor.id).setContent(this.element.innerHTML);
	this.tinymce.setContent(this.element.innerHTML);
  },
  removeForm: function($super) {
	try {
		this.tinymce.execCommand('mceRemoveEditor', false, this._controls.editor.id);
	} catch(e) {}
	$super();
  },
  // TODO: OPTIMIZATION: By adding the callback onLoadExternalText in the initial
  // InPlaceEditor would keep this code lighter and provide easier extentions
  loadExternalText: function() {
    this._form.addClassName(this.options.loadingClassName);
    this._controls.editor.disabled = true;
	// TODO: Find a way to disable the Rich editor
    var options = Object.extend({ method: 'get' }, this.options.ajaxOptions);
    Object.extend(options, {
      parameters: 'editorId=' + encodeURIComponent(this.element.id),
      onComplete: Prototype.emptyFunction,
      onSuccess: function(transport) {
        this._form.removeClassName(this.options.loadingClassName);
        var text = transport.responseText;
        if (this.options.stripLoadedTextTags)
          text = text.stripTags();
        this._controls.editor.value = text;
		// TODO: Replace when upgrading to tinyMCE 3.0
		// this.tinymce.get(this._controls.editor.id).setContent(text);
		this.tinymce.setContent(text);
        this._controls.editor.disabled = false;
        this.postProcessEditField();
      }.bind(this),
      onFailure: this._boundFailureHandler
    });
    new Ajax.Request(this.options.loadTextURL, options);
  },
  postProcessEditField: function() {
	// TODO: Make the activate option working
	var fpc = this.options.fieldPostCreation;
    if (fpc && fpc == 'focus')
      // FIXME: Find a better way to set the focus (don't work with Opera)
      tinyMCE.execCommand.delay(1, 'mceFocus', false, this._controls.editor.id);
  },
  prepareOptions: function() {
    this.options = Object.clone(Ajax.InPlaceRichEditor.DefaultOptions);
    Object.extend(this.options, Ajax.InPlaceRichEditor.DefaultCallbacks);
    [this._extraDefaultOptions].flatten().compact().each(function(defs) {
      Object.extend(this.options, defs);
    }.bind(this));
  }
});

Object.extend(Ajax.InPlaceRichEditor, {
  // size, cols, rows and autoRows options are now unused
  DefaultOptions: Object.extend(Ajax.InPlaceEditor.DefaultOptions, {
	// FIXME: Fix multiple timyMCE configs/inits
	editorClassName: 'editor_field',
    formClassName: 'inplacericheditor-form',
	formIdSuffix: 'inplacericheditor',
    loadingClassName: 'inplacericheditor-loading',
    savingClassName: 'inplacericheditor-saving',
	textareaIdSuffix: 'textarea-inplacericheditor'
  }),
  DefaultCallbacks: Object.clone(Ajax.InPlaceEditor.DefaultCallbacks)
});