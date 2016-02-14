{extends file="base.tpl"}
{block "content"}

<header id="student">
  <div class="cont_students">
    <nav class="topbar">
      <div class="lang">
        <a href="?lang=cat">CAT</a> |
        <a href="?lang=es">ESP</a> |
        <a href="?lang=en">ENG</a>
      </div>
      <a class="boton_cambio" href="copyshop.php">
        {$txt_btn_store}
      </a>
    </nav>
    <div class="contenedor">
      <h1><img src="{$img_logo}" title="A punt! estudiants"></h1>
      <h2>{$txt_logo_footer}</h2>
      <form>
        <input type="email" name="students_email" placeholder="{$txt_email}"  data-required="required">
        <input type="password" name="students_password" placeholder="{$txt_password}"  data-required="required">
        <button>{$txt_go}</button>
      </form>
        <p>
          {$txt_are_you_registered}
        </p>
    </div>
    <div class="boton_quisom">
      <a href="#quisom">{$txt_who_are_we}</a>
    </div>
  </div>
</header>
<section id="quisom">
  <div class="contenedor_quisom">
  {block "who_are_we"}{/block}
  </div>
{/block}
