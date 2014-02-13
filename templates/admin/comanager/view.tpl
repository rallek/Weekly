{* purpose of this template: comanagers view view in admin area *}
{include file='admin/header.tpl'}
<div class="weekly-comanager weekly-view">
    {gt text='Comanager list' assign='templateTitle'}
    {pagesetvar name='title' value=$templateTitle}
    <div class="z-admin-content-pagetitle">
        {icon type='view' size='small' alt=$templateTitle}
        <h3>{$templateTitle}</h3>
    </div>

    {if $canBeCreated}
        {checkpermissionblock component='Weekly:Comanager:' instance='::' level='ACCESS_EDIT'}
            {gt text='Create comanager' assign='createTitle'}
            <a href="{modurl modname='Weekly' type='admin' func='edit' ot='comanager'}" title="{$createTitle}" class="z-icon-es-add">{$createTitle}</a>
        {/checkpermissionblock}
    {/if}
    {assign var='own' value=0}
    {if isset($showOwnEntries) && $showOwnEntries eq 1}
        {assign var='own' value=1}
    {/if}
    {assign var='all' value=0}
    {if isset($showAllEntries) && $showAllEntries eq 1}
        {gt text='Back to paginated view' assign='linkTitle'}
        <a href="{modurl modname='Weekly' type='admin' func='view' ot='comanager'}" title="{$linkTitle}" class="z-icon-es-view">
            {$linkTitle}
        </a>
        {assign var='all' value=1}
    {else}
        {gt text='Show all entries' assign='linkTitle'}
        <a href="{modurl modname='Weekly' type='admin' func='view' ot='comanager' all=1}" title="{$linkTitle}" class="z-icon-es-view">{$linkTitle}</a>
    {/if}

    {include file='admin/comanager/view_quickNav.tpl' all=$all own=$own workflowStateFilter=false}{* see template file for available options *}

    <form action="{modurl modname='Weekly' type='admin' func='handleSelectedEntries'}" method="post" id="comanagersViewForm" class="z-form">
        <div>
            <input type="hidden" name="csrftoken" value="{insert name='csrftoken'}" />
            <input type="hidden" name="ot" value="comanager" />
            <table class="z-datatable">
                <colgroup>
                    <col id="cSelect" />
                    <col id="cComanagerName" />
                    <col id="cComanagerText" />
                    <col id="cComanagerPicture" />
                    <col id="cItemActions" />
                </colgroup>
                <thead>
                <tr>
                    <th id="hSelect" scope="col" align="center" valign="middle">
                        <input type="checkbox" id="toggleComanagers" />
                    </th>
                    <th id="hComanagerName" scope="col" class="z-left">
                        {sortlink __linktext='Comanager name' currentsort=$sort modname='Weekly' type='admin' func='view' ot='comanager' sort='comanagerName' sortdir=$sdir all=$all own=$own workflowState=$workflowState searchterm=$searchterm pageSize=$pageSize}
                    </th>
                    <th id="hComanagerText" scope="col" class="z-left">
                        {sortlink __linktext='Comanager text' currentsort=$sort modname='Weekly' type='admin' func='view' ot='comanager' sort='comanagerText' sortdir=$sdir all=$all own=$own workflowState=$workflowState searchterm=$searchterm pageSize=$pageSize}
                    </th>
                    <th id="hComanagerPicture" scope="col" class="z-left">
                        {sortlink __linktext='Comanager picture' currentsort=$sort modname='Weekly' type='admin' func='view' ot='comanager' sort='comanagerPicture' sortdir=$sdir all=$all own=$own workflowState=$workflowState searchterm=$searchterm pageSize=$pageSize}
                    </th>
                    <th id="hItemActions" scope="col" class="z-right z-order-unsorted">{gt text='Actions'}</th>
                </tr>
                </thead>
                <tbody>
            
            {foreach item='comanager' from=$items}
                <tr class="{cycle values='z-odd, z-even'}">
                    <td headers="hselect" align="center" valign="top">
                        <input type="checkbox" name="items[]" value="{$comanager.id}" class="comanagers-checkbox" />
                    </td>
                    <td headers="hComanagerName" class="z-left">
                        {$comanager.comanagerName}
                    </td>
                    <td headers="hComanagerText" class="z-left">
                        {$comanager.comanagerText}
                    </td>
                    <td headers="hComanagerPicture" class="z-left">
                        {if $comanager.comanagerPicture ne ''}
                          <a href="{$comanager.comanagerPictureFullPathURL}" title="{$comanager->getTitleFromDisplayPattern()|replace:"\"":""}"{if $comanager.comanagerPictureMeta.isImage} rel="imageviewer[comanager]"{/if}>
                          {if $comanager.comanagerPictureMeta.isImage}
                              {thumb image=$comanager.comanagerPictureFullPath objectid="comanager-`$comanager.id`" preset=$comanagerThumbPresetComanagerPicture tag=true img_alt=$comanager->getTitleFromDisplayPattern()}
                          {else}
                              {gt text='Download'} ({$comanager.comanagerPictureMeta.size|weeklyGetFileSize:$comanager.comanagerPictureFullPath:false:false})
                          {/if}
                          </a>
                        {else}&nbsp;{/if}
                    </td>
                    <td id="itemActions{$comanager.id}" headers="hItemActions" class="z-right z-nowrap z-w02">
                        {if count($comanager._actions) gt 0}
                            {foreach item='option' from=$comanager._actions}
                                <a href="{$option.url.type|weeklyActionUrl:$option.url.func:$option.url.arguments}" title="{$option.linkTitle|safetext}"{if $option.icon eq 'preview'} target="_blank"{/if}>{icon type=$option.icon size='extrasmall' alt=$option.linkText|safetext}</a>
                            {/foreach}
                            {icon id="itemActions`$comanager.id`Trigger" type='options' size='extrasmall' __alt='Actions' class='z-pointer z-hide'}
                            <script type="text/javascript">
                            /* <![CDATA[ */
                                document.observe('dom:loaded', function() {
                                    weeklyInitItemActions('comanager', 'view', 'itemActions{{$comanager.id}}');
                                });
                            /* ]]> */
                            </script>
                        {/if}
                    </td>
                </tr>
            {foreachelse}
                <tr class="z-admintableempty">
                  <td class="z-left" colspan="5">
                {gt text='No comanagers found.'}
                  </td>
                </tr>
            {/foreach}
            
                </tbody>
            </table>
            
            {if !isset($showAllEntries) || $showAllEntries ne 1}
                {pager rowcount=$pager.numitems limit=$pager.itemsperpage display='page' modname='Weekly' type='admin' func='view' ot='comanager'}
            {/if}
            <fieldset>
                <label for="weeklyAction">{gt text='With selected comanagers'}</label>
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
    if ($('toggleComanagers') != undefined) {
        $('toggleComanagers').observe('click', function (e) {
            Zikula.toggleInput('comanagersViewForm');
            e.stop()
        });
    }
    });
/* ]]> */
</script>
