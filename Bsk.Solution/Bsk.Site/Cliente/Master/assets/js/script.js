//menu mobile
const btnMobile = document.getElementById('btn-mobile')

function toggleMenu(e) {
  if (e.type === 'touchstart') e.preventDefault()
  const nav = document.getElementById('nav')
  nav.classList.toggle('active')
}

//dropfow menu

btnMobile.addEventListener('click', toggleMenu)
btnMobile.addEventListener('touchstart', toggleMenu)

const dropdowMenus = document.querySelectorAll('[data-dropdown]')

dropdowMenus.forEach(menu => {
  ['touchstart', 'click'].forEach(e => {
    menu.addEventListener(e, handleClick)
  })
})

function handleClick(event){
  this.classList.toggle('ativo-submenu')
  clicouFora( this,  () =>{
    this.classList.remove('ativo-submenu')
  })
}

  function clicouFora(element, callback){
    const outside =  'data-outside'
    const html = document.documentElement
    if(!element.hasAttribute(outside)){
      html.addEventListener('click', (e) => {
      if(!element.contains(e.target)){
        html.removeEventListener('click', this)
        callback()
      }
    })
  }
}

const menuToggle = document.querySelector('.open-menu');
menuToggle.addEventListener('click', () => {
    console.log("Antes do breakpoint");
    debugger; // A execu��o ir� parar aqui.
    console.log("Depois do breakpoint");

    const app = document.querySelector('.app');
    app.classList.toggle('mini-menu');

    // Verifica se o tamanho da tela � menor que 768px (tamanho t�pico de celular)
    if (window.innerWidth <= 768) {
        app.classList.remove('mini-menu');
        app.classList.add('sem-menu');
    } else {
        app.classList.remove('sem-menu');
    }
});

// Adiciona um listener para verificar redimensionamento da tela
window.addEventListener('resize', () => {
    const app = document.querySelector('.app');
    if (window.innerWidth <= 768) {
        app.classList.remove('mini-menu');
        app.classList.add('sem-menu');
    } else {
        app.classList.remove('sem-menu');
    }
});

  
    
function submenu(){
  const dropdow = document.querySelectorAll('[data-dropdow-perfil]')

  dropdow.forEach(menu => {
    ['touchstart', 'click'].forEach(userEvent => {
      menu.addEventListener(userEvent, handleClick)
    })
  })

  function handleClick(event) {
    this.classList.add('active-submenu')
    outsideClick(this, () =>{
      this.classList.remove('active-submenu')
    })
  }

  function outsideClick(element, callback){
    const html = document.documentElement
    const outside = 'data-outside'

    if(!element.hasAttribute(outside)) {
      html.addEventListener('click', handleOutsideClick)
      element.setAttribute(outside, '')
    }

    function handleOutsideClick (event){
      if(!element.contains(event.target)){
        element.removeAttribute(outside)
        html.removeEventListener('click', handleOutsideClick)
        callback()
      }
    }
  }

}
submenu()