{* purpose of this template: inclusion template for display of related comanagers in user area *}
{if !isset($nolink)}
    {assign var='nolink' value=false}
{/if}
{if isset($items) && $items ne null && count($items) gt 0}
<ul class="weekly-related-item-list comanager">
{foreach name='relLoop' item='item' from=$items}
    <li>
{strip}
{if !$nolink}
    <a href="{modurl modname='Weekly' type='user' func='display' ot='comanager' id=$item.id}" title="{$item->getTitleFromDisplayPattern()|replace:"\"":""}">
{/if}
    {$item->getTitleFromDisplayPattern()}
{if !$nolink}
    </a>
    <a id="comanagerItem{$item.id}Display" href="{modurl modname='Weekly' type='user' func='display' ot='comanager' id=$item.id theme='Printer' forcelongurl=true}" title="{gt text='Open quick view window'}" class="z-hide">{icon type='view' size='extrasmall' __alt='Quick view'}</a>
{/if}
{/strip}
{if !$nolink}
<script type="text/javascript">
/* <![CDATA[ */
    document.observe('dom:loaded', function() {
        weeklyInitInlineWindow($('comanagerItem{{$item.id}}Display'), '{{$item->getTitleFromDisplayPattern()|replace:"'":""}}');
    });
/* ]]> */
</script>
{/if}
<br />
{if $item.comanagerPicture ne '' && isset($item.comanagerPictureFullPath) && $item.comanagerPictureMeta.isImage}
    {thumb image=$item.comanagerPictureFullPath objectid="comanager-`$item.id`" preset=$relationThumbPreset tag=true img_alt=$item->getTitleFromDisplayPattern()}
{/if}
    </li>
{/foreach}
</ul>
{/if}
