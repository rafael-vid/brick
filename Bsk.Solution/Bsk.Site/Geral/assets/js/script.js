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

document.addEventListener('DOMContentLoaded', () => {
    const menuToggle = document.querySelector('.open-menu');
    if (menuToggle) {
        menuToggle.addEventListener('click', () => {
            const app = document.querySelector('.app');
            if (app) {
                app.classList.toggle('mini-menu');
            }
        });
    } else {
        console.error("Elemento '.open-menu' não encontrado!");
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