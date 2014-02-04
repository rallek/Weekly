{* purpose of this template: build the Form to edit an instance of comanager *}
{include file='admin/header.tpl'}
{pageaddvar name='javascript' value='modules/Weekly/javascript/Weekly_editFunctions.js'}
{pageaddvar name='javascript' value='modules/Weekly/javascript/Weekly_validation.js'}

{if $mode eq 'edit'}
    {gt text='Edit comanager' assign='templateTitle'}
    {assign var='adminPageIcon' value='edit'}
{elseif $mode eq 'create'}
    {gt text='Create comanager' assign='templateTitle'}
    {assign var='adminPageIcon' value='new'}
{else}
    {gt text='Edit comanager' assign='templateTitle'}
    {assign var='adminPageIcon' value='edit'}
{/if}
<div class="weekly-comanager weekly-edit">
    {pagesetvar name='title' value=$templateTitle}
    <div class="z-admin-content-pagetitle">
        {icon type=$adminPageIcon size='small' alt=$templateTitle}
        <h3>{$templateTitle}</h3>
    </div>
{form enctype='multipart/form-data' cssClass='z-form'}
    {* add validation summary and a <div> element for styling the form *}
    {weeklyFormFrame}
    {formsetinitialfocus inputId='comanagerName'}

    <fieldset>
        <legend>{gt text='Content'}</legend>
        
        <div class="z-formrow">
            {formlabel for='comanagerName' __text='Comanager name' mandatorysym='1' cssClass=''}
            {formtextinput group='comanager' id='comanagerName' mandatory=true readOnly=false __title='Enter the comanager name of the comanager' textMode='singleline' maxLength=255 cssClass='required' }
            {weeklyValidationError id='comanagerName' class='required'}
        </div>
        
        <div class="z-formrow">
            {formlabel for='comanagerText' __text='Comanager text' cssClass=''}
            {formtextinput group='comanager' id='comanagerText' mandatory=false __title='Enter the comanager text of the comanager' textMode='multiline' rows='6' cols='50' cssClass='' }
        </div>
        
        <div class="z-formrow">
            {formlabel for='comanagerPicture' __text='Comanager picture' cssClass=''}<br />{* break required for Google Chrome *}
            {formuploadinput group='comanager' id='comanagerPicture' mandatory=false readOnly=false cssClass=' validate-upload' }
            <span class="z-formnote"><a id="resetComanagerPictureVal" href="javascript:void(0);" class="z-hide">{gt text='Reset to empty value'}</a></span>
            
                <span class="z-formnote">{gt text='Allowed file extensions:'} <span id="comanagerPictureFileExtensions">gif, jpeg, jpg, png</span></span>
            <span class="z-formnote">{gt text='Allowed file size:'} {'102400'|weeklyGetFileSize:'':false:false}</span>
            {if $mode ne 'create'}
                {if $comanager.comanagerPicture ne ''}
                    <span class="z-formnote">
                        {gt text='Current file'}:
                        <a href="{$comanager.comanagerPictureFullPathUrl}" title="{$formattedEntityTitle|replace:"\"":""}"{if $comanager.comanagerPictureMeta.isImage} rel="imageviewer[comanager]"{/if}>
                        {if $comanager.comanagerPictureMeta.isImage}
                            {thumb image=$comanager.comanagerPictureFullPath objectid="comanager-`$comanager.id`" preset=$comanagerThumbPresetComanagerPicture tag=true img_alt=$formattedEntityTitle}
                        {else}
                            {gt text='Download'} ({$comanager.comanagerPictureMeta.size|weeklyGetFileSize:$comanager.comanagerPictureFullPath:false:false})
                        {/if}
                        </a>
                    </span>
                    <span class="z-formnote">
                        {formcheckbox group='comanager' id='comanagerPictureDeleteFile' readOnly=false __title='Delete comanager picture ?'}
                        {formlabel for='comanagerPictureDeleteFile' __text='Delete existing file'}
                    </span>
                {/if}
            {/if}
            {weeklyValidationError id='comanagerPicture' class='validate-upload'}
        </div>
    </fieldset>
    
    {if $mode ne 'create'}
        {include file='admin/include_standardfields_edit.tpl' obj=$comanager}
    {/if}
    
    {* include display hooks *}
    {if $mode ne 'create'}
        {assign var='hookId' value=$comanager.id}
        {notifydisplayhooks eventname='weekly.ui_hooks.comanagers.form_edit' id=$hookId assign='hooks'}
    {else}
        {notifydisplayhooks eventname='weekly.ui_hooks.comanagers.form_edit' id=null assign='hooks'}
    {/if}
    {if is_array($hooks) && count($hooks)}
        {foreach key='providerArea' item='hook' from=$hooks}
            <fieldset>
                {$hook}
            </fieldset>
        {/foreach}
    {/if}
    
    {* include return control *}
    {if $mode eq 'create'}
        <fieldset>
            <legend>{gt text='Return control'}</legend>
            <div class="z-formrow">
                {formlabel for='repeatCreation' __text='Create another item after save'}
                    {formcheckbox group='comanager' id='repeatCreation' readOnly=false}
            </div>
        </fieldset>
    {/if}
    
    {* include possible submit actions *}
    <div class="z-buttons z-formbuttons">
    {foreach item='action' from=$actions}
        {assign var='actionIdCapital' value=$action.id|@ucwords}
        {gt text=$action.title assign='actionTitle'}
        {*gt text=$action.description assign='actionDescription'*}{* TODO: formbutton could support title attributes *}
        {if $action.id eq 'delete'}
            {gt text='Really delete this comanager?' assign='deleteConfirmMsg'}
            {formbutton id="btn`$actionIdCapital`" commandName=$action.id text=$actionTitle class=$action.buttonClass confirmMessage=$deleteConfirmMsg}
        {else}
            {formbutton id="btn`$actionIdCapital`" commandName=$action.id text=$actionTitle class=$action.buttonClass}
        {/if}
    {/foreach}
        {formbutton id='btnCancel' commandName='cancel' __text='Cancel' class='z-bt-cancel'}
    </div>
    {/weeklyFormFrame}
{/form}
</div>
{include file='admin/footer.tpl'}

{icon type='edit' size='extrasmall' assign='editImageArray'}
{icon type='delete' size='extrasmall' assign='removeImageArray'}


<script type="text/javascript">
/* <![CDATA[ */

    var formButtons, formValidator;

    function handleFormButton (event) {
        var result = formValidator.validate();
        if (!result) {
            // validation error, abort form submit
            Event.stop(event);
        } else {
            // hide form buttons to prevent double submits by accident
            formButtons.each(function (btn) {
                btn.addClassName('z-hide');
            });
        }

        return result;
    }

    document.observe('dom:loaded', function() {

        weeklyAddCommonValidationRules('comanager', '{{if $mode ne 'create'}}{{$comanager.id}}{{/if}}');
        {{* observe validation on button events instead of form submit to exclude the cancel command *}}
        formValidator = new Validation('{{$__formid}}', {onSubmit: false, immediate: true, focusOnError: false});
        {{if $mode ne 'create'}}
            var result = formValidator.validate();
        {{/if}}

        formButtons = $('{{$__formid}}').select('div.z-formbuttons input');

        formButtons.each(function (elem) {
            if (elem.id != 'btnCancel') {
                elem.observe('click', handleFormButton);
            }
        });

        Zikula.UI.Tooltips($$('.weekly-form-tooltips'));
        weeklyInitUploadField('comanagerPicture');
    });

/* ]]> */
</script>
