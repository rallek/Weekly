{* purpose of this template: managers display view in admin area *}
{include file='admin/header.tpl'}
<div class="weekly-manager weekly-display with-rightbox">
    {gt text='Manager' assign='templateTitle'}
    {assign var='templateTitle' value=$manager->getTitleFromDisplayPattern()|default:$templateTitle}
    {pagesetvar name='title' value=$templateTitle|@html_entity_decode}
    <div class="z-admin-content-pagetitle">
        {icon type='display' size='small' __alt='Details'}
        <h3>{$templateTitle|notifyfilters:'weekly.filter_hooks.managers.filter'}{icon id='itemActionsTrigger' type='options' size='extrasmall' __alt='Actions' class='z-pointer z-hide'}</h3>
    </div>

    {if !isset($smarty.get.theme) || $smarty.get.theme ne 'Printer'}
        <div class="weekly-rightbox">
            <h4>{gt text='Events'}</h4>
            
            {if isset($manager.event) && $manager.event ne null}
                {include file='admin/event/include_displayItemListMany.tpl' items=$manager.event}
            {/if}
            
            {checkpermission component='Weekly:Manager:' instance="`$manager.id`::" level='ACCESS_ADMIN' assign='mayManage'}
            {if $mayManage || (isset($uid) && isset($manager.createdUserId) && $manager.createdUserId eq $uid)}
            <p class="managelink">
                {gt text='Create event' assign='createTitle'}
                <a href="{modurl modname='Weekly' type='admin' func='edit' ot='event' manager="`$manager.id`" returnTo='adminDisplayManager'}" title="{$createTitle}" class="z-icon-es-add">{$createTitle}</a>
            </p>
            {/if}
        </div>
    {/if}

    <dl>
        <dt>{gt text='Manager name'}</dt>
        <dd>{$manager.managerName}</dd>
        <dt>{gt text='Manager description'}</dt>
        <dd>{$manager.managerDescription}</dd>
        <dt>{gt text='Manager picture'}</dt>
        <dd>{if $manager.managerPicture ne ''}
          <a href="{$manager.managerPictureFullPathURL}" title="{$manager->getTitleFromDisplayPattern()|replace:"\"":""}"{if $manager.managerPictureMeta.isImage} rel="imageviewer[manager]"{/if}>
          {if $manager.managerPictureMeta.isImage}
              {thumb image=$manager.managerPictureFullPath objectid="manager-`$manager.id`" preset=$managerThumbPresetManagerPicture tag=true img_alt=$manager->getTitleFromDisplayPattern()}
          {else}
              {gt text='Download'} ({$manager.managerPictureMeta.size|weeklyGetFileSize:$manager.managerPictureFullPath:false:false})
          {/if}
          </a>
        {else}&nbsp;{/if}
        </dd>
        
    </dl>
    {include file='admin/include_standardfields_display.tpl' obj=$manager}

    {if !isset($smarty.get.theme) || $smarty.get.theme ne 'Printer'}
        {* include display hooks *}
        {notifydisplayhooks eventname='weekly.ui_hooks.managers.display_view' id=$manager.id urlobject=$currentUrlObject assign='hooks'}
        {foreach key='providerArea' item='hook' from=$hooks}
            {$hook}
        {/foreach}
        {if count($manager._actions) gt 0}
            <p id="itemActions">
            {foreach item='option' from=$manager._actions}
                <a href="{$option.url.type|weeklyActionUrl:$option.url.func:$option.url.arguments}" title="{$option.linkTitle|safetext}" class="z-icon-es-{$option.icon}">{$option.linkText|safetext}</a>
            {/foreach}
            </p>
            <script type="text/javascript">
            /* <![CDATA[ */
                document.observe('dom:loaded', function() {
                    weeklyInitItemActions('manager', 'display', 'itemActions');
                });
            /* ]]> */
            </script>
        {/if}
        <br style="clear: right" />
    {/if}
</div>
{include file='admin/footer.tpl'}
