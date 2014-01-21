{* purpose of this template: build the Form to edit an instance of location *}
{include file='user/header.tpl'}
{pageaddvar name='javascript' value='modules/Weekly/javascript/Weekly_editFunctions.js'}
{pageaddvar name='javascript' value='modules/Weekly/javascript/Weekly_validation.js'}

{if $mode eq 'edit'}
    {gt text='Edit location' assign='templateTitle'}
{elseif $mode eq 'create'}
    {gt text='Create location' assign='templateTitle'}
{else}
    {gt text='Edit location' assign='templateTitle'}
{/if}
<div class="weekly-location weekly-edit">
    {pagesetvar name='title' value=$templateTitle}
    <h2>{$templateTitle}</h2>
{form enctype='multipart/form-data' cssClass='z-form'}
    {* add validation summary and a <div> element for styling the form *}
    {weeklyFormFrame}
    {formsetinitialfocus inputId='locationName'}

    <fieldset>
        <legend>{gt text='Content'}</legend>
        
        <div class="z-formrow">
            {formlabel for='locationName' __text='Location name' mandatorysym='1' cssClass=''}
            {formtextinput group='location' id='locationName' mandatory=true readOnly=false __title='Enter the location name of the location' textMode='singleline' maxLength=255 cssClass='required' }
            {weeklyValidationError id='locationName' class='required'}
        </div>
        
        <div class="z-formrow">
            {formlabel for='locationText' __text='Location text' cssClass=''}
            {formtextinput group='location' id='locationText' mandatory=false __title='Enter the location text of the location' textMode='multiline' rows='6' cols='50' cssClass='' }
        </div>
        
        <div class="z-formrow">
            {formlabel for='locationPicture' __text='Location picture' cssClass=''}<br />{* break required for Google Chrome *}
            {formuploadinput group='location' id='locationPicture' mandatory=false readOnly=false cssClass=' validate-upload' }
            <span class="z-formnote"><a id="resetLocationPictureVal" href="javascript:void(0);" class="z-hide">{gt text='Reset to empty value'}</a></span>
            
                <span class="z-formnote">{gt text='Allowed file extensions:'} <span id="locationPictureFileExtensions">gif, jpeg, jpg, png</span></span>
            {if $mode ne 'create'}
                {if $location.locationPicture ne ''}
                    <span class="z-formnote">
                        {gt text='Current file'}:
                        <a href="{$location.locationPictureFullPathUrl}" title="{$formattedEntityTitle|replace:"\"":""}"{if $location.locationPictureMeta.isImage} rel="imageviewer[location]"{/if}>
                        {if $location.locationPictureMeta.isImage}
                            {thumb image=$location.locationPictureFullPath objectid="location-`$location.id`" preset=$locationThumbPresetLocationPicture tag=true img_alt=$formattedEntityTitle}
                        {else}
                            {gt text='Download'} ({$location.locationPictureMeta.size|weeklyGetFileSize:$location.locationPictureFullPath:false:false})
                        {/if}
                        </a>
                    </span>
                    <span class="z-formnote">
                        {formcheckbox group='location' id='locationPictureDeleteFile' readOnly=false __title='Delete location picture ?'}
                        {formlabel for='locationPictureDeleteFile' __text='Delete existing file'}
                    </span>
                {/if}
            {/if}
            {weeklyValidationError id='locationPicture' class='validate-upload'}
        </div>
    </fieldset>
    
    {if $mode ne 'create'}
        {include file='user/include_standardfields_edit.tpl' obj=$location}
    {/if}
    
    {* include display hooks *}
    {if $mode ne 'create'}
        {assign var='hookId' value=$location.id}
        {notifydisplayhooks eventname='weekly.ui_hooks.locations.form_edit' id=$hookId assign='hooks'}
    {else}
        {notifydisplayhooks eventname='weekly.ui_hooks.locations.form_edit' id=null assign='hooks'}
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
                    {formcheckbox group='location' id='repeatCreation' readOnly=false}
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
            {gt text='Really delete this location?' assign='deleteConfirmMsg'}
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
{include file='user/footer.tpl'}

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

        weeklyAddCommonValidationRules('location', '{{if $mode ne 'create'}}{{$location.id}}{{/if}}');
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
        weeklyInitUploadField('locationPicture');
    });

/* ]]> */
</script>
