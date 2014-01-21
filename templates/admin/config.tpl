{* purpose of this template: module configuration *}
{include file='admin/header.tpl'}
<div class="weekly-config">
    {gt text='Settings' assign='templateTitle'}
    {pagesetvar name='title' value=$templateTitle}
    <div class="z-admin-content-pagetitle">
        {icon type='config' size='small' __alt='Settings'}
        <h3>{$templateTitle}</h3>
    </div>

    {form cssClass='z-form'}
        {* add validation summary and a <div> element for styling the form *}
        {weeklyFormFrame}
            {formsetinitialfocus inputId='pageSize'}
            {gt text='Variables' assign='tabTitle'}
            <fieldset>
                <legend>{$tabTitle}</legend>
            
                <p class="z-confirmationmsg">{gt text='Here you can manage all basic settings for this application.'}</p>
            
                <div class="z-formrow">
                    {gt text='how many items per page' assign='toolTip'}
                    {formlabel for='pageSize' __text='Page size' cssClass='weekly-form-tooltips ' title=$toolTip}
                        {formintinput id='pageSize' group='config' maxLength=255 __title='Enter the page size. Only digits are allowed.'}
                </div>
                <div class="z-formrow">
                    {gt text='in bytes' assign='toolTip'}
                    {formlabel for='pictureSize' __text='Picture size' cssClass='weekly-form-tooltips ' title=$toolTip}
                        {formintinput id='pictureSize' group='config' maxLength=255 __title='Enter the picture size. Only digits are allowed.'}
                </div>
                <div class="z-formrow">
                    {gt text='we can switch the usage of leader table off' assign='toolTip'}
                    {formlabel for='showLeader' __text='Show leader' cssClass='weekly-form-tooltips ' title=$toolTip}
                        {formcheckbox id='showLeader' group='config'}
                </div>
                <div class="z-formrow">
                    {gt text='we can switch the usage of Organisator table off' assign='toolTip'}
                    {formlabel for='showOrganisator' __text='Show organisator' cssClass='weekly-form-tooltips ' title=$toolTip}
                        {formcheckbox id='showOrganisator' group='config'}
                </div>
                <div class="z-formrow">
                    {gt text='we can switch the usage of kind table off' assign='toolTip'}
                    {formlabel for='showKind' __text='Show kind' cssClass='weekly-form-tooltips ' title=$toolTip}
                        {formcheckbox id='showKind' group='config'}
                </div>
                <div class="z-formrow">
                    {gt text='we can switch the usage of location table off' assign='toolTip'}
                    {formlabel for='showLocation' __text='Show location' cssClass='weekly-form-tooltips ' title=$toolTip}
                        {formcheckbox id='showLocation' group='config'}
                </div>
                <div class="z-formrow">
                    {gt text='we can switch the usage of participants off' assign='toolTip'}
                    {formlabel for='showParticipants' __text='Show participants' cssClass='weekly-form-tooltips ' title=$toolTip}
                        {formcheckbox id='showParticipants' group='config'}
                </div>
                <div class="z-formrow">
                    {formlabel for='maxParticipantsDefault' __text='Max participants default' cssClass=''}
                        {formintinput id='maxParticipantsDefault' group='config' maxLength=255 __title='Enter the max participants default. Only digits are allowed.'}
                </div>
                <div class="z-formrow">
                    {gt text='we can allow to deactivate events' assign='toolTip'}
                    {formlabel for='allowDeactivating' __text='Allow deactivating' cssClass='weekly-form-tooltips ' title=$toolTip}
                        {formcheckbox id='allowDeactivating' group='config'}
                </div>
            </fieldset>

            <div class="z-buttons z-formbuttons">
                {formbutton commandName='save' __text='Update configuration' class='z-bt-save'}
                {formbutton commandName='cancel' __text='Cancel' class='z-bt-cancel'}
            </div>
        {/weeklyFormFrame}
    {/form}
</div>
{include file='admin/footer.tpl'}
<script type="text/javascript">
/* <![CDATA[ */
    document.observe('dom:loaded', function() {
        Zikula.UI.Tooltips($$('.weekly-form-tooltips'));
    });
/* ]]> */
</script>
