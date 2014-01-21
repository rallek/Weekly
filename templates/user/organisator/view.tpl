{* purpose of this template: organisators view view in user area *}
{include file='user/header.tpl'}
<div class="weekly-organisator weekly-view">
    {gt text='Organisator list' assign='templateTitle'}
    {pagesetvar name='title' value=$templateTitle}
    <h2>{$templateTitle}</h2>

    {if $canBeCreated}
        {checkpermissionblock component='Weekly:Organisator:' instance='::' level='ACCESS_EDIT'}
            {gt text='Create organisator' assign='createTitle'}
            <a href="{modurl modname='Weekly' type='user' func='edit' ot='organisator'}" title="{$createTitle}" class="z-icon-es-add">{$createTitle}</a>
        {/checkpermissionblock}
    {/if}
    {assign var='own' value=0}
    {if isset($showOwnEntries) && $showOwnEntries eq 1}
        {assign var='own' value=1}
    {/if}
    {assign var='all' value=0}
    {if isset($showAllEntries) && $showAllEntries eq 1}
        {gt text='Back to paginated view' assign='linkTitle'}
        <a href="{modurl modname='Weekly' type='user' func='view' ot='organisator'}" title="{$linkTitle}" class="z-icon-es-view">
            {$linkTitle}
        </a>
        {assign var='all' value=1}
    {else}
        {gt text='Show all entries' assign='linkTitle'}
        <a href="{modurl modname='Weekly' type='user' func='view' ot='organisator' all=1}" title="{$linkTitle}" class="z-icon-es-view">{$linkTitle}</a>
    {/if}

    {include file='user/organisator/view_quickNav.tpl' all=$all own=$own workflowStateFilter=false}{* see template file for available options *}

    <table class="z-datatable">
        <colgroup>
            <col id="cOrganisatorName" />
            <col id="cOrganisatorText" />
            <col id="cOrganisatorPicture" />
            <col id="cItemActions" />
        </colgroup>
        <thead>
        <tr>
            <th id="hOrganisatorName" scope="col" class="z-left">
                {sortlink __linktext='Organisator name' currentsort=$sort modname='Weekly' type='user' func='view' ot='organisator' sort='organisatorName' sortdir=$sdir all=$all own=$own workflowState=$workflowState searchterm=$searchterm pageSize=$pageSize}
            </th>
            <th id="hOrganisatorText" scope="col" class="z-left">
                {sortlink __linktext='Organisator text' currentsort=$sort modname='Weekly' type='user' func='view' ot='organisator' sort='organisatorText' sortdir=$sdir all=$all own=$own workflowState=$workflowState searchterm=$searchterm pageSize=$pageSize}
            </th>
            <th id="hOrganisatorPicture" scope="col" class="z-left">
                {sortlink __linktext='Organisator picture' currentsort=$sort modname='Weekly' type='user' func='view' ot='organisator' sort='organisatorPicture' sortdir=$sdir all=$all own=$own workflowState=$workflowState searchterm=$searchterm pageSize=$pageSize}
            </th>
            <th id="hItemActions" scope="col" class="z-right z-order-unsorted">{gt text='Actions'}</th>
        </tr>
        </thead>
        <tbody>
    
    {foreach item='organisator' from=$items}
        <tr class="{cycle values='z-odd, z-even'}">
            <td headers="hOrganisatorName" class="z-left">
                {$organisator.organisatorName}
            </td>
            <td headers="hOrganisatorText" class="z-left">
                {$organisator.organisatorText}
            </td>
            <td headers="hOrganisatorPicture" class="z-left">
                {if $organisator.organisatorPicture ne ''}
                  <a href="{$organisator.organisatorPictureFullPathURL}" title="{$organisator->getTitleFromDisplayPattern()|replace:"\"":""}"{if $organisator.organisatorPictureMeta.isImage} rel="imageviewer[organisator]"{/if}>
                  {if $organisator.organisatorPictureMeta.isImage}
                      {thumb image=$organisator.organisatorPictureFullPath objectid="organisator-`$organisator.id`" preset=$organisatorThumbPresetOrganisatorPicture tag=true img_alt=$organisator->getTitleFromDisplayPattern()}
                  {else}
                      {gt text='Download'} ({$organisator.organisatorPictureMeta.size|weeklyGetFileSize:$organisator.organisatorPictureFullPath:false:false})
                  {/if}
                  </a>
                {else}&nbsp;{/if}
            </td>
            <td id="itemActions{$organisator.id}" headers="hItemActions" class="z-right z-nowrap z-w02">
                {if count($organisator._actions) gt 0}
                    {foreach item='option' from=$organisator._actions}
                        <a href="{$option.url.type|weeklyActionUrl:$option.url.func:$option.url.arguments}" title="{$option.linkTitle|safetext}"{if $option.icon eq 'preview'} target="_blank"{/if}>{icon type=$option.icon size='extrasmall' alt=$option.linkText|safetext}</a>
                    {/foreach}
                    {icon id="itemActions`$organisator.id`Trigger" type='options' size='extrasmall' __alt='Actions' class='z-pointer z-hide'}
                    <script type="text/javascript">
                    /* <![CDATA[ */
                        document.observe('dom:loaded', function() {
                            weeklyInitItemActions('organisator', 'view', 'itemActions{{$organisator.id}}');
                        });
                    /* ]]> */
                    </script>
                {/if}
            </td>
        </tr>
    {foreachelse}
        <tr class="z-datatableempty">
          <td class="z-left" colspan="4">
        {gt text='No organisators found.'}
          </td>
        </tr>
    {/foreach}
    
        </tbody>
    </table>
    
    {if !isset($showAllEntries) || $showAllEntries ne 1}
        {pager rowcount=$pager.numitems limit=$pager.itemsperpage display='page' modname='Weekly' type='user' func='view' ot='organisator'}
    {/if}

    
    {notifydisplayhooks eventname='weekly.ui_hooks.organisators.display_view' urlobject=$currentUrlObject assign='hooks'}
    {foreach key='providerArea' item='hook' from=$hooks}
        {$hook}
    {/foreach}
</div>
{include file='user/footer.tpl'}
