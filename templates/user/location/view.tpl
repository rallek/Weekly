{* purpose of this template: locations view view in user area *}
{include file='user/header.tpl'}
<div class="weekly-location weekly-view">
    {gt text='Location list' assign='templateTitle'}
    {pagesetvar name='title' value=$templateTitle}
    <h2>{$templateTitle}</h2>

    {if $canBeCreated}
        {checkpermissionblock component='Weekly:Location:' instance='::' level='ACCESS_EDIT'}
            {gt text='Create location' assign='createTitle'}
            <a href="{modurl modname='Weekly' type='user' func='edit' ot='location'}" title="{$createTitle}" class="z-icon-es-add">{$createTitle}</a>
        {/checkpermissionblock}
    {/if}
    {assign var='own' value=0}
    {if isset($showOwnEntries) && $showOwnEntries eq 1}
        {assign var='own' value=1}
    {/if}
    {assign var='all' value=0}
    {if isset($showAllEntries) && $showAllEntries eq 1}
        {gt text='Back to paginated view' assign='linkTitle'}
        <a href="{modurl modname='Weekly' type='user' func='view' ot='location'}" title="{$linkTitle}" class="z-icon-es-view">
            {$linkTitle}
        </a>
        {assign var='all' value=1}
    {else}
        {gt text='Show all entries' assign='linkTitle'}
        <a href="{modurl modname='Weekly' type='user' func='view' ot='location' all=1}" title="{$linkTitle}" class="z-icon-es-view">{$linkTitle}</a>
    {/if}

    {include file='user/location/view_quickNav.tpl' all=$all own=$own workflowStateFilter=false}{* see template file for available options *}

    <table class="z-datatable">
        <colgroup>
            <col id="cLocationName" />
            <col id="cLocationText" />
            <col id="cLocationPicture" />
            <col id="cItemActions" />
        </colgroup>
        <thead>
        <tr>
            <th id="hLocationName" scope="col" class="z-left">
                {sortlink __linktext='Location name' currentsort=$sort modname='Weekly' type='user' func='view' ot='location' sort='locationName' sortdir=$sdir all=$all own=$own workflowState=$workflowState searchterm=$searchterm pageSize=$pageSize}
            </th>
            <th id="hLocationText" scope="col" class="z-left">
                {sortlink __linktext='Location text' currentsort=$sort modname='Weekly' type='user' func='view' ot='location' sort='locationText' sortdir=$sdir all=$all own=$own workflowState=$workflowState searchterm=$searchterm pageSize=$pageSize}
            </th>
            <th id="hLocationPicture" scope="col" class="z-left">
                {sortlink __linktext='Location picture' currentsort=$sort modname='Weekly' type='user' func='view' ot='location' sort='locationPicture' sortdir=$sdir all=$all own=$own workflowState=$workflowState searchterm=$searchterm pageSize=$pageSize}
            </th>
            <th id="hItemActions" scope="col" class="z-right z-order-unsorted">{gt text='Actions'}</th>
        </tr>
        </thead>
        <tbody>
    
    {foreach item='location' from=$items}
        <tr class="{cycle values='z-odd, z-even'}">
            <td headers="hLocationName" class="z-left">
                {$location.locationName}
            </td>
            <td headers="hLocationText" class="z-left">
                {$location.locationText}
            </td>
            <td headers="hLocationPicture" class="z-left">
                {if $location.locationPicture ne ''}
                  <a href="{$location.locationPictureFullPathURL}" title="{$location->getTitleFromDisplayPattern()|replace:"\"":""}"{if $location.locationPictureMeta.isImage} rel="imageviewer[location]"{/if}>
                  {if $location.locationPictureMeta.isImage}
                      {thumb image=$location.locationPictureFullPath objectid="location-`$location.id`" preset=$locationThumbPresetLocationPicture tag=true img_alt=$location->getTitleFromDisplayPattern()}
                  {else}
                      {gt text='Download'} ({$location.locationPictureMeta.size|weeklyGetFileSize:$location.locationPictureFullPath:false:false})
                  {/if}
                  </a>
                {else}&nbsp;{/if}
            </td>
            <td id="itemActions{$location.id}" headers="hItemActions" class="z-right z-nowrap z-w02">
                {if count($location._actions) gt 0}
                    {foreach item='option' from=$location._actions}
                        <a href="{$option.url.type|weeklyActionUrl:$option.url.func:$option.url.arguments}" title="{$option.linkTitle|safetext}"{if $option.icon eq 'preview'} target="_blank"{/if}>{icon type=$option.icon size='extrasmall' alt=$option.linkText|safetext}</a>
                    {/foreach}
                    {icon id="itemActions`$location.id`Trigger" type='options' size='extrasmall' __alt='Actions' class='z-pointer z-hide'}
                    <script type="text/javascript">
                    /* <![CDATA[ */
                        document.observe('dom:loaded', function() {
                            weeklyInitItemActions('location', 'view', 'itemActions{{$location.id}}');
                        });
                    /* ]]> */
                    </script>
                {/if}
            </td>
        </tr>
    {foreachelse}
        <tr class="z-datatableempty">
          <td class="z-left" colspan="4">
        {gt text='No locations found.'}
          </td>
        </tr>
    {/foreach}
    
        </tbody>
    </table>
    
    {if !isset($showAllEntries) || $showAllEntries ne 1}
        {pager rowcount=$pager.numitems limit=$pager.itemsperpage display='page' modname='Weekly' type='user' func='view' ot='location'}
    {/if}

    
    {notifydisplayhooks eventname='weekly.ui_hooks.locations.display_view' urlobject=$currentUrlObject assign='hooks'}
    {foreach key='providerArea' item='hook' from=$hooks}
        {$hook}
    {/foreach}
</div>
{include file='user/footer.tpl'}
