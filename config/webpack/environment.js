const { environment } = require('@rails/webpacker')

const webpack = require('webpack')
environment.plugins.prepend('Provide',
  new webpack.ProvidePlugin({
    $: 'jquery/src/jquery',
    jQuery: 'jquery/src/jquery'
  })
)

// Material design
// import { MDCRipple } from '@material/ripple';
// import { MDCMenu } from '@material/menu';
// import { MDCChipSet } from '@material/chips';

// const fabRipple = new MDCRipple(document.querySelector('.mdc-fab'));
// const menu = new MDCMenu(document.querySelector('.mdc-menu'));
// menu.open = true;
// const chipSetEl = document.querySelector('.mdc-chip-set');
// const chipSet = new MDCChipSet(chipSetEl);
// const selector = '.mdc-button, .mdc-icon-button, .mdc-card__primary-action';
// const ripples = [].map.call(document.querySelectorAll(selector), function(el) {
//   return new MDCRipple(el);
// });

module.exports = environment
