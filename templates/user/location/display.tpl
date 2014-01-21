{* purpose of this template: locations display view in user area *}
{include file='user/header.tpl'}
<div class="weekly-location weekly-display with-rightbox">
    {gt text='Location' assign='templateTitle'}
    {assign var='templateTitle' value=$location->getTitleFromDisplayPattern()|default:$templateTitle}
    {pagesetvar name='title' value=$templateTitle|@html_entity_decode}
    <h2>{$templateTitle|notifyfilters:'weekly.filter_hooks.locations.filter'}{icon id='itemActionsTrigger' type='options' size='extrasmall' __alt='Actions' class='z-pointer z-hide'}</h2>

    {if !isset($smarty.get.theme) || $smarty.get.theme ne 'Printer'}
        <div class="weekly-rightbox">
            <h3>{gt text='Events'}</h3>
            
            {if isset($location.event) && $location.event ne null}
                {include file='user/event/include_displayItemListMany.tpl' items=$location.event}
            {/if}
            
            {checkpermission component='Weekly:Location:' instance="`$location.id`::" level='ACCESS_EDIT' assign='mayManage'}
            {if $mayManage || (isset($uid) && isset($location.createdUserId) && $location.createdUserId eq $uid)}
            <p class="managelink">
                {gt text='Create event' assign='createTitle'}
                <a href="{modurl modname='Weekly' type='user' func='edit' ot='event' location="`$location.id`" returnTo='userDisplayLocation'}" title="{$createTitle}" class="z-icon-es-add">{$createTitle}</a>
            </p>
            {/if}
        </div>
    {/if}

    <dl>
        <dt>{gt text='Location name'}</dt>
        <dd>{$location.locationName}</dd>
        <dt>{gt text='Location text'}</dt>
        <dd>{$location.locationText}</dd>
        <dt>{gt text='Location picture'}</dt>
        <dd>{if $location.locationPicture ne ''}
          <a href="{$location.locationPictureFullPathURL}" title="{$location->getTitleFromDisplayPattern()|replace:"\"":""}"{if $location.locationPictureMeta.isImage} rel="imageviewer[location]"{/if}>
          {if $location.locationPictureMeta.isImage}
              {thumb image=$location.locationPictureFullPath objectid="location-`$location.id`" preset=$locationThumbPresetLocationPicture tag=true img_alt=$location->getTitleFromDisplayPattern()}
          {else}
              {gt text='Download'} ({$location.locationPictureMeta.size|weeklyGetFileSize:$location.locationPictureFullPath:false:false})
          {/if}
          </a>
        {else}&nbsp;{/if}
        </dd>
        
    </dl>
    {include file='user/include_standardfields_display.tpl' obj=$location}

    {if !isset($smarty.get.theme) || $smarty.get.theme ne 'Printer'}
        {* include display hooks *}
        {notifydisplayhooks eventname='weekly.ui_hooks.locations.display_view' id=$location.id urlobject=$currentUrlObject assign='hooks'}
        {foreach key='providerArea' item='hook' from=$hooks}
            {$hook}
        {/foreach}
        {if count($location._actions) gt 0}
            <p id="itemActions">
            {foreach item='option' from=$location._actions}
                <a href="{$option.url.type|weeklyActionUrl:$option.url.func:$option.url.arguments}" title="{$option.linkTitle|safetext}" class="z-icon-es-{$option.icon}">{$option.linkText|safetext}</a>
            {/foreach}
            </p>
            <script type="text/javascript">
            /* <![CDATA[ */
                document.observe('dom:loaded', function() {
                    weeklyInitItemActions('location', 'display', 'itemActions');
                });
            /* ]]> */
            </script>
        {/if}
        <br style="clear: right" />
    {/if}
</div>
{include file='user/footer.tpl'}
