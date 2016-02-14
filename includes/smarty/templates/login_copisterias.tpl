{extends file="base.tpl"}
{block "content"}

<header id="copy">
  <div class="cont_copy">
    <nav class="topbar">
      <div class="lang">
        <a href="?lang=cat">CAT</a> |
        <a href="?lang=es">ESP</a> |
        <a href="?lang=en">ENG</a>
      </div>
      <a class="boton_cambio" href="index.php">
        {$txt_btn_student}
      </a>
    </nav>
    <div class="contenedor">
      <h1><img src="{$img_logo}" title="A punt! copisteries"></h1>
      <h2></h2>
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
