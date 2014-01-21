{* purpose of this template: kind view view in admin area *}
{include file='admin/header.tpl'}
<div class="weekly-kind weekly-view">
    {gt text='Kind list' assign='templateTitle'}
    {pagesetvar name='title' value=$templateTitle}
    <div class="z-admin-content-pagetitle">
        {icon type='view' size='small' alt=$templateTitle}
        <h3>{$templateTitle}</h3>
    </div>

    {if $canBeCreated}
        {checkpermissionblock component='Weekly:Kind:' instance='::' level='ACCESS_EDIT'}
            {gt text='Create kind' assign='createTitle'}
            <a href="{modurl modname='Weekly' type='admin' func='edit' ot='kind'}" title="{$createTitle}" class="z-icon-es-add">{$createTitle}</a>
        {/checkpermissionblock}
    {/if}
    {assign var='own' value=0}
    {if isset($showOwnEntries) && $showOwnEntries eq 1}
        {assign var='own' value=1}
    {/if}
    {assign var='all' value=0}
    {if isset($showAllEntries) && $showAllEntries eq 1}
        {gt text='Back to paginated view' assign='linkTitle'}
        <a href="{modurl modname='Weekly' type='admin' func='view' ot='kind'}" title="{$linkTitle}" class="z-icon-es-view">
            {$linkTitle}
        </a>
        {assign var='all' value=1}
    {else}
        {gt text='Show all entries' assign='linkTitle'}
        <a href="{modurl modname='Weekly' type='admin' func='view' ot='kind' all=1}" title="{$linkTitle}" class="z-icon-es-view">{$linkTitle}</a>
    {/if}

    {include file='admin/kind/view_quickNav.tpl' all=$all own=$own workflowStateFilter=false}{* see template file for available options *}

    <form action="{modurl modname='Weekly' type='admin' func='handleSelectedEntries'}" method="post" id="kindViewForm" class="z-form">
        <div>
            <input type="hidden" name="csrftoken" value="{insert name='csrftoken'}" />
            <input type="hidden" name="ot" value="kind" />
            <table class="z-datatable">
                <colgroup>
                    <col id="cSelect" />
                    <col id="cKindName" />
                    <col id="cKindText" />
                    <col id="cKindPicture" />
                    <col id="cItemActions" />
                </colgroup>
                <thead>
                <tr>
                    <th id="hSelect" scope="col" align="center" valign="middle">
                        <input type="checkbox" id="toggleKind" />
                    </th>
                    <th id="hKindName" scope="col" class="z-left">
                        {sortlink __linktext='Kind name' currentsort=$sort modname='Weekly' type='admin' func='view' ot='kind' sort='kindName' sortdir=$sdir all=$all own=$own workflowState=$workflowState searchterm=$searchterm pageSize=$pageSize}
                    </th>
                    <th id="hKindText" scope="col" class="z-left">
                        {sortlink __linktext='Kind text' currentsort=$sort modname='Weekly' type='admin' func='view' ot='kind' sort='kindText' sortdir=$sdir all=$all own=$own workflowState=$workflowState searchterm=$searchterm pageSize=$pageSize}
                    </th>
                    <th id="hKindPicture" scope="col" class="z-left">
                        {sortlink __linktext='Kind picture' currentsort=$sort modname='Weekly' type='admin' func='view' ot='kind' sort='kindPicture' sortdir=$sdir all=$all own=$own workflowState=$workflowState searchterm=$searchterm pageSize=$pageSize}
                    </th>
                    <th id="hItemActions" scope="col" class="z-right z-order-unsorted">{gt text='Actions'}</th>
                </tr>
                </thead>
                <tbody>
            
            {foreach item='kind' from=$items}
                <tr class="{cycle values='z-odd, z-even'}">
                    <td headers="hselect" align="center" valign="top">
                        <input type="checkbox" name="items[]" value="{$kind.id}" class="kind-checkbox" />
                    </td>
                    <td headers="hKindName" class="z-left">
                        {$kind.kindName}
                    </td>
                    <td headers="hKindText" class="z-left">
                        {$kind.kindText}
                    </td>
                    <td headers="hKindPicture" class="z-left">
                        {if $kind.kindPicture ne ''}
                          <a href="{$kind.kindPictureFullPathURL}" title="{$kind->getTitleFromDisplayPattern()|replace:"\"":""}"{if $kind.kindPictureMeta.isImage} rel="imageviewer[kind]"{/if}>
                          {if $kind.kindPictureMeta.isImage}
                              {thumb image=$kind.kindPictureFullPath objectid="kind-`$kind.id`" preset=$kindThumbPresetKindPicture tag=true img_alt=$kind->getTitleFromDisplayPattern()}
                          {else}
                              {gt text='Download'} ({$kind.kindPictureMeta.size|weeklyGetFileSize:$kind.kindPictureFullPath:false:false})
                          {/if}
                          </a>
                        {else}&nbsp;{/if}
                    </td>
                    <td id="itemActions{$kind.id}" headers="hItemActions" class="z-right z-nowrap z-w02">
                        {if count($kind._actions) gt 0}
                            {foreach item='option' from=$kind._actions}
                                <a href="{$option.url.type|weeklyActionUrl:$option.url.func:$option.url.arguments}" title="{$option.linkTitle|safetext}"{if $option.icon eq 'preview'} target="_blank"{/if}>{icon type=$option.icon size='extrasmall' alt=$option.linkText|safetext}</a>
                            {/foreach}
                            {icon id="itemActions`$kind.id`Trigger" type='options' size='extrasmall' __alt='Actions' class='z-pointer z-hide'}
                            <script type="text/javascript">
                            /* <![CDATA[ */
                                document.observe('dom:loaded', function() {
                                    weeklyInitItemActions('kind', 'view', 'itemActions{{$kind.id}}');
                                });
                            /* ]]> */
                            </script>
                        {/if}
                    </td>
                </tr>
            {foreachelse}
                <tr class="z-admintableempty">
                  <td class="z-left" colspan="5">
                {gt text='No kind found.'}
                  </td>
                </tr>
            {/foreach}
            
                </tbody>
            </table>
            
            {if !isset($showAllEntries) || $showAllEntries ne 1}
                {pager rowcount=$pager.numitems limit=$pager.itemsperpage display='page' modname='Weekly' type='admin' func='view' ot='kind'}
            {/if}
            <fieldset>
                <label for="weeklyAction">{gt text='With selected kind'}</label>
                <select id="weeklyAction" name="action">
                    <option value="">{gt text='Choose action'}</option>
                    <option value="delete" title="{gt text='Delete content permanently.'}">{gt text='Delete'}</option>
                </select>
                <input type="submit" value="{gt text='Submit'}" />
            </fieldset>
        </div>
    </form>

</div>
{include file='admin/footer.tpl'}

<script type="text/javascript">
/* <![CDATA[ */
    document.observe('dom:loaded', function() {
    {{* init the "toggle all" functionality *}}
    if ($('toggleKind') != undefined) {
        $('toggleKind').observe('click', function (e) {
            Zikula.toggleInput('kindViewForm');
            e.stop()
        });
    }
    });
/* ]]> */
</script>
