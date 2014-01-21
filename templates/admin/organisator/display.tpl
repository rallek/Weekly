{* purpose of this template: organisators display view in admin area *}
{include file='admin/header.tpl'}
<div class="weekly-organisator weekly-display with-rightbox">
    {gt text='Organisator' assign='templateTitle'}
    {assign var='templateTitle' value=$organisator->getTitleFromDisplayPattern()|default:$templateTitle}
    {pagesetvar name='title' value=$templateTitle|@html_entity_decode}
    <div class="z-admin-content-pagetitle">
        {icon type='display' size='small' __alt='Details'}
        <h3>{$templateTitle|notifyfilters:'weekly.filter_hooks.organisators.filter'}{icon id='itemActionsTrigger' type='options' size='extrasmall' __alt='Actions' class='z-pointer z-hide'}</h3>
    </div>

    {if !isset($smarty.get.theme) || $smarty.get.theme ne 'Printer'}
        <div class="weekly-rightbox">
            <h4>{gt text='Events'}</h4>
            
            {if isset($organisator.event) && $organisator.event ne null}
                {include file='admin/event/include_displayItemListMany.tpl' items=$organisator.event}
            {/if}
            
            {checkpermission component='Weekly:Organisator:' instance="`$organisator.id`::" level='ACCESS_ADMIN' assign='mayManage'}
            {if $mayManage || (isset($uid) && isset($organisator.createdUserId) && $organisator.createdUserId eq $uid)}
            <p class="managelink">
                {gt text='Create event' assign='createTitle'}
                <a href="{modurl modname='Weekly' type='admin' func='edit' ot='event' organisator="`$organisator.id`" returnTo='adminDisplayOrganisator'}" title="{$createTitle}" class="z-icon-es-add">{$createTitle}</a>
            </p>
            {/if}
        </div>
    {/if}

    <dl>
        <dt>{gt text='Organisator name'}</dt>
        <dd>{$organisator.organisatorName}</dd>
        <dt>{gt text='Organisator text'}</dt>
        <dd>{$organisator.organisatorText}</dd>
        <dt>{gt text='Organisator picture'}</dt>
        <dd>{if $organisator.organisatorPicture ne ''}
          <a href="{$organisator.organisatorPictureFullPathURL}" title="{$organisator->getTitleFromDisplayPattern()|replace:"\"":""}"{if $organisator.organisatorPictureMeta.isImage} rel="imageviewer[organisator]"{/if}>
          {if $organisator.organisatorPictureMeta.isImage}
              {thumb image=$organisator.organisatorPictureFullPath objectid="organisator-`$organisator.id`" preset=$organisatorThumbPresetOrganisatorPicture tag=true img_alt=$organisator->getTitleFromDisplayPattern()}
          {else}
              {gt text='Download'} ({$organisator.organisatorPictureMeta.size|weeklyGetFileSize:$organisator.organisatorPictureFullPath:false:false})
          {/if}
          </a>
        {else}&nbsp;{/if}
        </dd>
        
    </dl>
    {include file='admin/include_standardfields_display.tpl' obj=$organisator}

    {if !isset($smarty.get.theme) || $smarty.get.theme ne 'Printer'}
        {* include display hooks *}
        {notifydisplayhooks eventname='weekly.ui_hooks.organisators.display_view' id=$organisator.id urlobject=$currentUrlObject assign='hooks'}
        {foreach key='providerArea' item='hook' from=$hooks}
            {$hook}
        {/foreach}
        {if count($organisator._actions) gt 0}
            <p id="itemActions">
            {foreach item='option' from=$organisator._actions}
                <a href="{$option.url.type|weeklyActionUrl:$option.url.func:$option.url.arguments}" title="{$option.linkTitle|safetext}" class="z-icon-es-{$option.icon}">{$option.linkText|safetext}</a>
            {/foreach}
            </p>
            <script type="text/javascript">
            /* <![CDATA[ */
                document.observe('dom:loaded', function() {
                    weeklyInitItemActions('organisator', 'display', 'itemActions');
                });
            /* ]]> */
            </script>
        {/if}
        <br style="clear: right" />
    {/if}
</div>
{include file='admin/footer.tpl'}
