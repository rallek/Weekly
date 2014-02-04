{* purpose of this template: build the Form to edit an instance of event *}
{pageaddvar name='javascript' value='jquery'}
{include file='user/header.tpl'}
{include file='include_eventbegin.tpl'}
{pageaddvar name='javascript' value='modules/Weekly/javascript/Weekly_editFunctions.js'}
{pageaddvar name='javascript' value='modules/Weekly/javascript/Weekly_validation.js'}

{if $mode eq 'edit'}
    {gt text='Edit event' assign='templateTitle'}
{elseif $mode eq 'create'}
    {gt text='Create event' assign='templateTitle'}
{else}
    {gt text='Edit event' assign='templateTitle'}
{/if}
<div class="weekly-event weekly-edit">
    {pagesetvar name='title' value=$templateTitle}
    <h2>{$templateTitle}</h2>
{form cssClass='z-form'}
    {* add validation summary and a <div> element for styling the form *}
    {weeklyFormFrame}
    {formsetinitialfocus inputId='eventBegin'}

    <fieldset>
        <legend>{gt text='Content'}</legend>
        
        <div class="z-formrow z-hide">
            {formlabel for='eventBegin' __text='Event begin' cssClass=''}
            {if $mode ne 'create'}
                {formdateinput group='event' id='eventBegin' mandatory=false __title='Enter the event begin of the event' includeTime=true cssClass='' }
            {else}
                {formdateinput group='event' id='eventBegin' mandatory=false __title='Enter the event begin of the event' includeTime=true defaultValue='2013-12-17 00:00:00' cssClass='' }
            {/if}
            
        </div>
        
        <div class="z-formrow">
            {formlabel for='eventName' __text='Event name' mandatorysym='1' cssClass=''}
            {formtextinput group='event' id='eventName' mandatory=true readOnly=false __title='Enter the event name of the event' textMode='singleline' maxLength=255 cssClass='required' }
            {weeklyValidationError id='eventName' class='required'}
        </div>
        
        <div class="z-formrow">
            {formlabel for='eventDay' __text='Event day' mandatorysym='1' cssClass=''}
            {formdropdownlist group='event' id='eventDay' mandatory=true __title='Choose the event day' selectionMode='single'}
        </div>
        
        <div class="z-formrow">
            {gt text='The time when the event begins' assign='toolTip'}
            {formlabel for='eventBeginText' __text='Event begin text' mandatorysym='1' cssClass='weekly-form-tooltips' title=$toolTip}
            {formtextinput group='event' id='eventBeginText' mandatory=true readOnly=false __title='Enter the event begin text of the event' textMode='singleline' minLength=5 maxLength=5 cssClass='required' }
            {weeklyValidationError id='eventBeginText' class='required'}
        </div>
        
        <div class="z-formrow">
            {gt text='The time how long the event takes normaly (in minutes)' assign='toolTip'}
            {formlabel for='eventDuration' __text='Event duration' mandatorysym='1' cssClass='weekly-form-tooltips' title=$toolTip}
            {formintinput group='event' id='eventDuration' mandatory=true __title='Enter the event duration of the event' maxLength=11 cssClass='required validate-digits' }
            {weeklyValidationError id='eventDuration' class='required'}
            {weeklyValidationError id='eventDuration' class='validate-digits'}
        </div>
        
        <div class="z-formrow">
            {gt text='be so kind and write a date and not only next week' assign='toolTip'}
            {formlabel for='eventMessage' __text='Event message' cssClass='weekly-form-tooltips' title=$toolTip}
            {formtextinput group='event' id='eventMessage' mandatory=false readOnly=false __title='Enter the event message of the event' textMode='singleline' maxLength=255 cssClass='' }
        </div>
        
        <div class="z-formrow">
            {formlabel for='eventText' __text='Event text' cssClass=''}
            {formtextinput group='event' id='eventText' mandatory=false __title='Enter the event text of the event' textMode='multiline' rows='6' cols='50' cssClass='' }
        </div>
        
		{if $modvars.Weekly.showParticipants}
        <div class="z-formrow">
            {formlabel for='maxParticipants' __text='Max participants' cssClass=''}
            {formintinput group='event' id='maxParticipants' mandatory=false __title='Enter the max participants of the event' maxLength=11 cssClass=' validate-digits' }
            {weeklyValidationError id='maxParticipants' class='validate-digits'}
        </div>
        
        <div class="z-formrow">
            {formlabel for='currentParticipants' __text='Current participants' cssClass=''}
            {formintinput group='event' id='currentParticipants' mandatory=false __title='Enter the current participants of the event' maxLength=11 cssClass=' validate-digits' }
            {weeklyValidationError id='currentParticipants' class='validate-digits'}
        </div>
        {/if}
		{if $modvars.Weekly.allowDeactivating}
        <div class="z-formrow">
            {gt text='if you deactivate the event is not shown in the user view' assign='toolTip'}
            {formlabel for='active' __text='Active' cssClass='weekly-form-tooltips' title=$toolTip}
            {formcheckbox group='event' id='active' readOnly=false __title='active ?' cssClass='' }
        </div>
		{/if}
    </fieldset>
    
    {if $modvars.Weekly.showKind}
		{include file='user/kind/include_selectOne.tpl' group='event' alias='kind' aliasReverse='event' mandatory=false idPrefix='weeklyEvent_Kind' linkingItem=$event displayMode='dropdown' allowEditing=false}
	{/if}
	{if $modvars.Weekly.showLocation}
		{include file='user/location/include_selectOne.tpl' group='event' alias='location' aliasReverse='event' mandatory=false idPrefix='weeklyEvent_Location' linkingItem=$event displayMode='dropdown' allowEditing=false}
	{/if}
	{if $modvars.Weekly.showManager}
		{include file='user/manager/include_selectOne.tpl' group='event' alias='manager' aliasReverse='event' mandatory=false idPrefix='weeklyEvent_Manager' linkingItem=$event displayMode='dropdown' allowEditing=false}
	{/if}
	{if $modvars.Weekly.showComanager}
		{include file='user/comanager/include_selectOne.tpl' group='event' alias='comanager' aliasReverse='event' mandatory=false idPrefix='weeklyEvent_Comanager' linkingItem=$event displayMode='dropdown' allowEditing=false}
	{/if}
    {if $mode ne 'create'}
        {include file='user/include_standardfields_edit.tpl' obj=$event}
    {/if}
    
    {* include display hooks *}
    {if $mode ne 'create'}
        {assign var='hookId' value=$event.id}
        {notifydisplayhooks eventname='weekly.ui_hooks.events.form_edit' id=$hookId assign='hooks'}
    {else}
        {notifydisplayhooks eventname='weekly.ui_hooks.events.form_edit' id=null assign='hooks'}
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
                    {formcheckbox group='event' id='repeatCreation' readOnly=false}
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
            {gt text='Really delete this event?' assign='deleteConfirmMsg'}
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

        weeklyAddCommonValidationRules('event', '{{if $mode ne 'create'}}{{$event.id}}{{/if}}');
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
    });

/* ]]> */
</script>
