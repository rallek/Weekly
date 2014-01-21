{* purpose of this template: build the Form to edit an instance of leader *}
{include file='admin/header.tpl'}
{pageaddvar name='javascript' value='modules/Weekly/javascript/Weekly_editFunctions.js'}
{pageaddvar name='javascript' value='modules/Weekly/javascript/Weekly_validation.js'}

{if $mode eq 'edit'}
    {gt text='Edit leader' assign='templateTitle'}
    {assign var='adminPageIcon' value='edit'}
{elseif $mode eq 'create'}
    {gt text='Create leader' assign='templateTitle'}
    {assign var='adminPageIcon' value='new'}
{else}
    {gt text='Edit leader' assign='templateTitle'}
    {assign var='adminPageIcon' value='edit'}
{/if}
<div class="weekly-leader weekly-edit">
    {pagesetvar name='title' value=$templateTitle}
    <div class="z-admin-content-pagetitle">
        {icon type=$adminPageIcon size='small' alt=$templateTitle}
        <h3>{$templateTitle}</h3>
    </div>
{form enctype='multipart/form-data' cssClass='z-form'}
    {* add validation summary and a <div> element for styling the form *}
    {weeklyFormFrame}
    {formsetinitialfocus inputId='leaderName'}

    <fieldset>
        <legend>{gt text='Content'}</legend>
        
        <div class="z-formrow">
            {formlabel for='leaderName' __text='Leader name' mandatorysym='1' cssClass=''}
            {formtextinput group='leader' id='leaderName' mandatory=true readOnly=false __title='Enter the leader name of the leader' textMode='singleline' maxLength=255 cssClass='required validate-unique' }
            {weeklyValidationError id='leaderName' class='required'}
            {weeklyValidationError id='leaderName' class='validate-unique'}
        </div>
        
        <div class="z-formrow">
            {formlabel for='leaderDescription' __text='Leader description' cssClass=''}
            {formtextinput group='leader' id='leaderDescription' mandatory=false __title='Enter the leader description of the leader' textMode='multiline' rows='6' cols='50' cssClass='' }
        </div>
        
        <div class="z-formrow">
            {formlabel for='leaderPicture' __text='Leader picture' cssClass=''}<br />{* break required for Google Chrome *}
            {formuploadinput group='leader' id='leaderPicture' mandatory=false readOnly=false cssClass=' validate-upload' }
            <span class="z-formnote"><a id="resetLeaderPictureVal" href="javascript:void(0);" class="z-hide">{gt text='Reset to empty value'}</a></span>
            
                <span class="z-formnote">{gt text='Allowed file extensions:'} <span id="leaderPictureFileExtensions">gif, jpeg, jpg, png</span></span>
            <span class="z-formnote">{gt text='Allowed file size:'} {'102400'|weeklyGetFileSize:'':false:false}</span>
            {if $mode ne 'create'}
                {if $leader.leaderPicture ne ''}
                    <span class="z-formnote">
                        {gt text='Current file'}:
                        <a href="{$leader.leaderPictureFullPathUrl}" title="{$formattedEntityTitle|replace:"\"":""}"{if $leader.leaderPictureMeta.isImage} rel="imageviewer[leader]"{/if}>
                        {if $leader.leaderPictureMeta.isImage}
                            {thumb image=$leader.leaderPictureFullPath objectid="leader-`$leader.id`" preset=$leaderThumbPresetLeaderPicture tag=true img_alt=$formattedEntityTitle}
                        {else}
                            {gt text='Download'} ({$leader.leaderPictureMeta.size|weeklyGetFileSize:$leader.leaderPictureFullPath:false:false})
                        {/if}
                        </a>
                    </span>
                    <span class="z-formnote">
                        {formcheckbox group='leader' id='leaderPictureDeleteFile' readOnly=false __title='Delete leader picture ?'}
                        {formlabel for='leaderPictureDeleteFile' __text='Delete existing file'}
                    </span>
                {/if}
            {/if}
            {weeklyValidationError id='leaderPicture' class='validate-upload'}
        </div>
    </fieldset>
    
    {if $mode ne 'create'}
        {include file='admin/include_standardfields_edit.tpl' obj=$leader}
    {/if}
    
    {* include display hooks *}
    {if $mode ne 'create'}
        {assign var='hookId' value=$leader.id}
        {notifydisplayhooks eventname='weekly.ui_hooks.leaders.form_edit' id=$hookId assign='hooks'}
    {else}
        {notifydisplayhooks eventname='weekly.ui_hooks.leaders.form_edit' id=null assign='hooks'}
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
                    {formcheckbox group='leader' id='repeatCreation' readOnly=false}
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
            {gt text='Really delete this leader?' assign='deleteConfirmMsg'}
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

        weeklyAddCommonValidationRules('leader', '{{if $mode ne 'create'}}{{$leader.id}}{{/if}}');
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
        weeklyInitUploadField('leaderPicture');
    });

/* ]]> */
</script>
