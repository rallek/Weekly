{* purpose of this template: build the Form to edit an instance of kind *}
{include file='admin/header.tpl'}
{pageaddvar name='javascript' value='modules/Weekly/javascript/Weekly_editFunctions.js'}
{pageaddvar name='javascript' value='modules/Weekly/javascript/Weekly_validation.js'}

{if $mode eq 'edit'}
    {gt text='Edit kind' assign='templateTitle'}
    {assign var='adminPageIcon' value='edit'}
{elseif $mode eq 'create'}
    {gt text='Create kind' assign='templateTitle'}
    {assign var='adminPageIcon' value='new'}
{else}
    {gt text='Edit kind' assign='templateTitle'}
    {assign var='adminPageIcon' value='edit'}
{/if}
<div class="weekly-kind weekly-edit">
    {pagesetvar name='title' value=$templateTitle}
    <div class="z-admin-content-pagetitle">
        {icon type=$adminPageIcon size='small' alt=$templateTitle}
        <h3>{$templateTitle}</h3>
    </div>
{form enctype='multipart/form-data' cssClass='z-form'}
    {* add validation summary and a <div> element for styling the form *}
    {weeklyFormFrame}
    {formsetinitialfocus inputId='kindName'}

    <fieldset>
        <legend>{gt text='Content'}</legend>
        
        <div class="z-formrow">
            {formlabel for='kindName' __text='Kind name' mandatorysym='1' cssClass=''}
            {formtextinput group='kind' id='kindName' mandatory=true readOnly=false __title='Enter the kind name of the kind' textMode='singleline' maxLength=255 cssClass='required' }
            {weeklyValidationError id='kindName' class='required'}
        </div>
        
        <div class="z-formrow">
            {formlabel for='kindText' __text='Kind text' cssClass=''}
            {formtextinput group='kind' id='kindText' mandatory=false __title='Enter the kind text of the kind' textMode='multiline' rows='6' cols='50' cssClass='' }
        </div>
        
        <div class="z-formrow">
            {formlabel for='kindPicture' __text='Kind picture' cssClass=''}<br />{* break required for Google Chrome *}
            {formuploadinput group='kind' id='kindPicture' mandatory=false readOnly=false cssClass=' validate-upload' }
            <span class="z-formnote"><a id="resetKindPictureVal" href="javascript:void(0);" class="z-hide">{gt text='Reset to empty value'}</a></span>
            
                <span class="z-formnote">{gt text='Allowed file extensions:'} <span id="kindPictureFileExtensions">gif, jpeg, jpg, png</span></span>
            {if $mode ne 'create'}
                {if $kind.kindPicture ne ''}
                    <span class="z-formnote">
                        {gt text='Current file'}:
                        <a href="{$kind.kindPictureFullPathUrl}" title="{$formattedEntityTitle|replace:"\"":""}"{if $kind.kindPictureMeta.isImage} rel="imageviewer[kind]"{/if}>
                        {if $kind.kindPictureMeta.isImage}
                            {thumb image=$kind.kindPictureFullPath objectid="kind-`$kind.id`" preset=$kindThumbPresetKindPicture tag=true img_alt=$formattedEntityTitle}
                        {else}
                            {gt text='Download'} ({$kind.kindPictureMeta.size|weeklyGetFileSize:$kind.kindPictureFullPath:false:false})
                        {/if}
                        </a>
                    </span>
                    <span class="z-formnote">
                        {formcheckbox group='kind' id='kindPictureDeleteFile' readOnly=false __title='Delete kind picture ?'}
                        {formlabel for='kindPictureDeleteFile' __text='Delete existing file'}
                    </span>
                {/if}
            {/if}
            {weeklyValidationError id='kindPicture' class='validate-upload'}
        </div>
    </fieldset>
    
    {if $mode ne 'create'}
        {include file='admin/include_standardfields_edit.tpl' obj=$kind}
    {/if}
    
    {* include display hooks *}
    {if $mode ne 'create'}
        {assign var='hookId' value=$kind.id}
        {notifydisplayhooks eventname='weekly.ui_hooks.kind.form_edit' id=$hookId assign='hooks'}
    {else}
        {notifydisplayhooks eventname='weekly.ui_hooks.kind.form_edit' id=null assign='hooks'}
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
                    {formcheckbox group='kind' id='repeatCreation' readOnly=false}
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
            {gt text='Really delete this kind?' assign='deleteConfirmMsg'}
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

        weeklyAddCommonValidationRules('kind', '{{if $mode ne 'create'}}{{$kind.id}}{{/if}}');
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
        weeklyInitUploadField('kindPicture');
    });

/* ]]> */
</script>
