{* Purpose of this template: Display comanagers within an external context *}
{foreach item='comanager' from=$items}
    <h3>{$comanager->getTitleFromDisplayPattern()}</h3>
    <p><a href="{modurl modname='Weekly' type='user' func='display' ot=$objectType id=$comanager.id}">{gt text='Read more'}</a>
    </p>
{/foreach}
