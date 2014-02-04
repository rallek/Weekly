{* purpose of this template: managers view view in user area *}
{include file='user/header.tpl'}
<div class="weekly-manager weekly-view">
    {gt text='Manager list' assign='templateTitle'}
    {pagesetvar name='title' value=$templateTitle}
    <h2>{$templateTitle}</h2>

    {if $canBeCreated}
        {checkpermissionblock component='Weekly:Manager:' instance='::' level='ACCESS_EDIT'}
            {gt text='Create manager' assign='createTitle'}
            <a href="{modurl modname='Weekly' type='user' func='edit' ot='manager'}" title="{$createTitle}" class="z-icon-es-add">{$createTitle}</a>
        {/checkpermissionblock}
    {/if}
    {assign var='own' value=0}
    {if isset($showOwnEntries) && $showOwnEntries eq 1}
        {assign var='own' value=1}
    {/if}
    {assign var='all' value=0}
    {if isset($showAllEntries) && $showAllEntries eq 1}
        {gt text='Back to paginated view' assign='linkTitle'}
        <a href="{modurl modname='Weekly' type='user' func='view' ot='manager'}" title="{$linkTitle}" class="z-icon-es-view">
            {$linkTitle}
        </a>
        {assign var='all' value=1}
    {else}
        {gt text='Show all entries' assign='linkTitle'}
        <a href="{modurl modname='Weekly' type='user' func='view' ot='manager' all=1}" title="{$linkTitle}" class="z-icon-es-view">{$linkTitle}</a>
    {/if}

    {include file='user/manager/view_quickNav.tpl' all=$all own=$own workflowStateFilter=false}{* see template file for available options *}

    <table class="z-datatable">
        <colgroup>
            <col id="cManagerName" />
            <col id="cManagerDescription" />
            <col id="cManagerPicture" />
            <col id="cItemActions" />
        </colgroup>
        <thead>
        <tr>
            <th id="hManagerName" scope="col" class="z-left">
                {sortlink __linktext='Manager name' currentsort=$sort modname='Weekly' type='user' func='view' ot='manager' sort='managerName' sortdir=$sdir all=$all own=$own workflowState=$workflowState searchterm=$searchterm pageSize=$pageSize}
            </th>
            <th id="hManagerDescription" scope="col" class="z-left">
                {sortlink __linktext='Manager description' currentsort=$sort modname='Weekly' type='user' func='view' ot='manager' sort='managerDescription' sortdir=$sdir all=$all own=$own workflowState=$workflowState searchterm=$searchterm pageSize=$pageSize}
            </th>
            <th id="hManagerPicture" scope="col" class="z-left">
                {sortlink __linktext='Manager picture' currentsort=$sort modname='Weekly' type='user' func='view' ot='manager' sort='managerPicture' sortdir=$sdir all=$all own=$own workflowState=$workflowState searchterm=$searchterm pageSize=$pageSize}
            </th>
            <th id="hItemActions" scope="col" class="z-right z-order-unsorted">{gt text='Actions'}</th>
        </tr>
        </thead>
        <tbody>
    
    {foreach item='manager' from=$items}
        <tr class="{cycle values='z-odd, z-even'}">
            <td headers="hManagerName" class="z-left">
                {$manager.managerName}
            </td>
            <td headers="hManagerDescription" class="z-left">
                {$manager.managerDescription}
            </td>
            <td headers="hManagerPicture" class="z-left">
                {if $manager.managerPicture ne ''}
                  <a href="{$manager.managerPictureFullPathURL}" title="{$manager->getTitleFromDisplayPattern()|replace:"\"":""}"{if $manager.managerPictureMeta.isImage} rel="imageviewer[manager]"{/if}>
                  {if $manager.managerPictureMeta.isImage}
                      {thumb image=$manager.managerPictureFullPath objectid="manager-`$manager.id`" preset=$managerThumbPresetManagerPicture tag=true img_alt=$manager->getTitleFromDisplayPattern()}
                  {else}
                      {gt text='Download'} ({$manager.managerPictureMeta.size|weeklyGetFileSize:$manager.managerPictureFullPath:false:false})
                  {/if}
                  </a>
                {else}&nbsp;{/if}
            </td>
            <td id="itemActions{$manager.id}" headers="hItemActions" class="z-right z-nowrap z-w02">
                {if count($manager._actions) gt 0}
                    {foreach item='option' from=$manager._actions}
                        <a href="{$option.url.type|weeklyActionUrl:$option.url.func:$option.url.arguments}" title="{$option.linkTitle|safetext}"{if $option.icon eq 'preview'} target="_blank"{/if}>{icon type=$option.icon size='extrasmall' alt=$option.linkText|safetext}</a>
                    {/foreach}
                    {icon id="itemActions`$manager.id`Trigger" type='options' size='extrasmall' __alt='Actions' class='z-pointer z-hide'}
                    <script type="text/javascript">
                    /* <![CDATA[ */
                        document.observe('dom:loaded', function() {
                            weeklyInitItemActions('manager', 'view', 'itemActions{{$manager.id}}');
                        });
                    /* ]]> */
                    </script>
                {/if}
            </td>
        </tr>
    {foreachelse}
        <tr class="z-datatableempty">
          <td class="z-left" colspan="4">
        {gt text='No managers found.'}
          </td>
        </tr>
    {/foreach}
    
        </tbody>
    </table>
    
    {if !isset($showAllEntries) || $showAllEntries ne 1}
        {pager rowcount=$pager.numitems limit=$pager.itemsperpage display='page' modname='Weekly' type='user' func='view' ot='manager'}
    {/if}

    
    {notifydisplayhooks eventname='weekly.ui_hooks.managers.display_view' urlobject=$currentUrlObject assign='hooks'}
    {foreach key='providerArea' item='hook' from=$hooks}
        {$hook}
    {/foreach}
</div>
{include file='user/footer.tpl'}
