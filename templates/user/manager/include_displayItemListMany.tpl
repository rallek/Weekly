{* purpose of this template: inclusion template for display of related managers in user area *}
{if !isset($nolink)}
    {assign var='nolink' value=false}
{/if}
{if isset($items) && $items ne null && count($items) gt 0}
<ul class="weekly-related-item-list manager">
{foreach name='relLoop' item='item' from=$items}
    <li>
{strip}
{if !$nolink}
    <a href="{modurl modname='Weekly' type='user' func='display' ot='manager' id=$item.id}" title="{$item->getTitleFromDisplayPattern()|replace:"\"":""}">
{/if}
    {$item->getTitleFromDisplayPattern()}
{if !$nolink}
    </a>
    <a id="managerItem{$item.id}Display" href="{modurl modname='Weekly' type='user' func='display' ot='manager' id=$item.id theme='Printer' forcelongurl=true}" title="{gt text='Open quick view window'}" class="z-hide">{icon type='view' size='extrasmall' __alt='Quick view'}</a>
{/if}
{/strip}
{if !$nolink}
<script type="text/javascript">
/* <![CDATA[ */
    document.observe('dom:loaded', function() {
        weeklyInitInlineWindow($('managerItem{{$item.id}}Display'), '{{$item->getTitleFromDisplayPattern()|replace:"'":""}}');
    });
/* ]]> */
</script>
{/if}
<br />
{if $item.managerPicture ne '' && isset($item.managerPictureFullPath) && $item.managerPictureMeta.isImage}
    {thumb image=$item.managerPictureFullPath objectid="manager-`$item.id`" preset=$relationThumbPreset tag=true img_alt=$item->getTitleFromDisplayPattern()}
{/if}
    </li>
{/foreach}
</ul>
{/if}
