// ============================================================================================================================
// Javascript / page related functions // Sven Scharfenberg 03.06.2011
// Javascript / Slide up & down added // Andreas Schmalfeldt 08.06.2011
// ============================================================================================================================


$(document).ready(function() {

  // Function definitions -----------------------------------------------------------------------------------------------------
  // Parse Query String
  function getParameterByName(name) {
    var match = RegExp('[?&]' + name + '=([^&]*)').exec(window.location.search);
    return match && decodeURIComponent(match[1].replace(/\+/g, ' '));
  }
  // Scroll to ID
  function scrollto(scrollid) {
    jumptoid = "#" + scrollid;
    var op = jQuery.browser.opera ? jQuery("html") : jQuery("html, body"); // if opera, html and body must be animated
    op.animate({ scrollTop: jQuery(jumptoid).offset().top },'fast');       // scroll to the correct ID
  }

  // Page specific dynamics ---------------------------------------------------------------------------------------------------
  // PAGE: PRODUCTS ==========================================================
  // register clicks on product categories and show the appropriate listview
  $("div.tabs-nav ul.click li").click(function(){
    var currentid = "#" + this.id;                                        // what ID has been clicked?
    var showdetailid = "#tab_" + this.id;                                 // corresponding detail tab
    $("div.tab").hide();                                                  // hide all other tabs and remove all "current" classes
    $("ul.click li").removeClass("current");
    $(showdetailid).show();                                               // now show it
    $("ul.click li" + currentid).addClass("current");                     // and add class=current to clicked tab
    scrollto("tab_block");
  });

  $("div.tabs-nav ul.click").mouseover(function() {
    $("ul.click li").addClass("notover");
  })

  $("div.tabs-nav ul.click li").mouseover(function() {
    var currentid = "#" + this.id;
    $("ul.click li" + currentid).addClass("over");
  }).mouseout(function(){
    $("ul.click li").removeClass("over");
  });

  // Slide up & down
  $(function(){
    var handler = $('div.moviesection h3'),
    menus = $('div.moviesection div.movielist');
    handler.click(function(){
      var _thisMenu = $(this).next();
      if(_thisMenu.is(':visible')){
        _thisMenu.show();
      }
      else {
        menus.slideUp();
        _thisMenu.slideDown();
      }
    });
  });

  // Check if URL contains parameter for area, then show area from URL
  $(document).ready(function(){
    var param = location.href.match("(.*)[/\?&/]area=(.+):*(&*)");
    if ((param) && (param.length > 2))  {
      showArea = param[2];
      _tmp_show = $('div#'+showArea);
      _tmp_show.show();
    }
  });
});


// ============================================================================================================================
// jQuery fancybox plugin + jQuery easing
// ============================================================================================================================


/*
 * jQuery Easing v1.3 - http://gsgd.co.uk/sandbox/jquery/easing/
 *
 * Uses the built in easing capabilities added In jQuery 1.1
 * to offer multiple easing options
 *
 * TERMS OF USE - jQuery Easing
 *
 * Open source under the BSD License.
 *
 * Copyright Ã‚Â© 2008 George McGinley Smith
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without modification,
 * are permitted provided that the following conditions are met:
 *
 * Redistributions of source code must retain the above copyright notice, this list of
 * conditions and the following disclaimer.
 * Redistributions in binary form must reproduce the above copyright notice, this list
 * of conditions and the following disclaimer in the documentation and/or other materials
 * provided with the distribution.
 *
 * Neither the name of the author nor the names of contributors may be used to endorse
 * or promote products derived from this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY
 * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
 * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE
 *  COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
 *  EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE
 *  GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED
 * AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
 *  NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED
 * OF THE POSSIBILITY OF SUCH DAMAGE.
 *
*/

// t: current time, b: begInnIng value, c: change In value, d: duration
jQuery.easing['jswing'] = jQuery.easing['swing'];

jQuery.extend( jQuery.easing,
{
  def: 'easeOutQuad',
  swing: function (x, t, b, c, d) {
    //alert(jQuery.easing.default);
    return jQuery.easing[jQuery.easing.def](x, t, b, c, d);
  },
  easeInQuad: function (x, t, b, c, d) {
    return c*(t/=d)*t + b;
  },
  easeOutQuad: function (x, t, b, c, d) {
    return -c *(t/=d)*(t-2) + b;
  },
  easeInOutQuad: function (x, t, b, c, d) {
    if ((t/=d/2) < 1) return c/2*t*t + b;
    return -c/2 * ((--t)*(t-2) - 1) + b;
  },
  easeInCubic: function (x, t, b, c, d) {
    return c*(t/=d)*t*t + b;
  },
  easeOutCubic: function (x, t, b, c, d) {
    return c*((t=t/d-1)*t*t + 1) + b;
  },
  easeInOutCubic: function (x, t, b, c, d) {
    if ((t/=d/2) < 1) return c/2*t*t*t + b;
    return c/2*((t-=2)*t*t + 2) + b;
  },
  easeInQuart: function (x, t, b, c, d) {
    return c*(t/=d)*t*t*t + b;
  },
  easeOutQuart: function (x, t, b, c, d) {
    return -c * ((t=t/d-1)*t*t*t - 1) + b;
  },
  easeInOutQuart: function (x, t, b, c, d) {
    if ((t/=d/2) < 1) return c/2*t*t*t*t + b;
    return -c/2 * ((t-=2)*t*t*t - 2) + b;
  },
  easeInQuint: function (x, t, b, c, d) {
    return c*(t/=d)*t*t*t*t + b;
  },
  easeOutQuint: function (x, t, b, c, d) {
    return c*((t=t/d-1)*t*t*t*t + 1) + b;
  },
  easeInOutQuint: function (x, t, b, c, d) {
    if ((t/=d/2) < 1) return c/2*t*t*t*t*t + b;
    return c/2*((t-=2)*t*t*t*t + 2) + b;
  },
  easeInSine: function (x, t, b, c, d) {
    return -c * Math.cos(t/d * (Math.PI/2)) + c + b;
  },
  easeOutSine: function (x, t, b, c, d) {
    return c * Math.sin(t/d * (Math.PI/2)) + b;
  },
  easeInOutSine: function (x, t, b, c, d) {
    return -c/2 * (Math.cos(Math.PI*t/d) - 1) + b;
  },
  easeInExpo: function (x, t, b, c, d) {
    return (t==0) ? b : c * Math.pow(2, 10 * (t/d - 1)) + b;
  },
  easeOutExpo: function (x, t, b, c, d) {
    return (t==d) ? b+c : c * (-Math.pow(2, -10 * t/d) + 1) + b;
  },
  easeInOutExpo: function (x, t, b, c, d) {
    if (t==0) return b;
    if (t==d) return b+c;
    if ((t/=d/2) < 1) return c/2 * Math.pow(2, 10 * (t - 1)) + b;
    return c/2 * (-Math.pow(2, -10 * --t) + 2) + b;
  },
  easeInCirc: function (x, t, b, c, d) {
    return -c * (Math.sqrt(1 - (t/=d)*t) - 1) + b;
  },
  easeOutCirc: function (x, t, b, c, d) {
    return c * Math.sqrt(1 - (t=t/d-1)*t) + b;
  },
  easeInOutCirc: function (x, t, b, c, d) {
    if ((t/=d/2) < 1) return -c/2 * (Math.sqrt(1 - t*t) - 1) + b;
    return c/2 * (Math.sqrt(1 - (t-=2)*t) + 1) + b;
  },
  easeInElastic: function (x, t, b, c, d) {
    var s=1.70158;var p=0;var a=c;
    if (t==0) return b;  if ((t/=d)==1) return b+c;  if (!p) p=d*.3;
    if (a < Math.abs(c)) { a=c; var s=p/4; }
    else var s = p/(2*Math.PI) * Math.asin (c/a);
    return -(a*Math.pow(2,10*(t-=1)) * Math.sin( (t*d-s)*(2*Math.PI)/p )) + b;
  },
  easeOutElastic: function (x, t, b, c, d) {
    var s=1.70158;var p=0;var a=c;
    if (t==0) return b;  if ((t/=d)==1) return b+c;  if (!p) p=d*.3;
    if (a < Math.abs(c)) { a=c; var s=p/4; }
    else var s = p/(2*Math.PI) * Math.asin (c/a);
    return a*Math.pow(2,-10*t) * Math.sin( (t*d-s)*(2*Math.PI)/p ) + c + b;
  },
  easeInOutElastic: function (x, t, b, c, d) {
    var s=1.70158;var p=0;var a=c;
    if (t==0) return b;  if ((t/=d/2)==2) return b+c;  if (!p) p=d*(.3*1.5);
    if (a < Math.abs(c)) { a=c; var s=p/4; }
    else var s = p/(2*Math.PI) * Math.asin (c/a);
    if (t < 1) return -.5*(a*Math.pow(2,10*(t-=1)) * Math.sin( (t*d-s)*(2*Math.PI)/p )) + b;
    return a*Math.pow(2,-10*(t-=1)) * Math.sin( (t*d-s)*(2*Math.PI)/p )*.5 + c + b;
  },
  easeInBack: function (x, t, b, c, d, s) {
    if (s == undefined) s = 1.70158;
    return c*(t/=d)*t*((s+1)*t - s) + b;
  },
  easeOutBack: function (x, t, b, c, d, s) {
    if (s == undefined) s = 1.70158;
    return c*((t=t/d-1)*t*((s+1)*t + s) + 1) + b;
  },
  easeInOutBack: function (x, t, b, c, d, s) {
    if (s == undefined) s = 1.70158;
    if ((t/=d/2) < 1) return c/2*(t*t*(((s*=(1.525))+1)*t - s)) + b;
    return c/2*((t-=2)*t*(((s*=(1.525))+1)*t + s) + 2) + b;
  },
  easeInBounce: function (x, t, b, c, d) {
    return c - jQuery.easing.easeOutBounce (x, d-t, 0, c, d) + b;
  },
  easeOutBounce: function (x, t, b, c, d) {
    if ((t/=d) < (1/2.75)) {
      return c*(7.5625*t*t) + b;
    } else if (t < (2/2.75)) {
      return c*(7.5625*(t-=(1.5/2.75))*t + .75) + b;
    } else if (t < (2.5/2.75)) {
      return c*(7.5625*(t-=(2.25/2.75))*t + .9375) + b;
    } else {
      return c*(7.5625*(t-=(2.625/2.75))*t + .984375) + b;
    }
  },
  easeInOutBounce: function (x, t, b, c, d) {
    if (t < d/2) return jQuery.easing.easeInBounce (x, t*2, 0, c, d) * .5 + b;
    return jQuery.easing.easeOutBounce (x, t*2-d, 0, c, d) * .5 + c*.5 + b;
  }
});

/*
 *
 * TERMS OF USE - EASING EQUATIONS
 *
 * Open source under the BSD License.
 *
 * Copyright Â© 2001 Robert Penner
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without modification,
 * are permitted provided that the following conditions are met:
 *
 * Redistributions of source code must retain the above copyright notice, this list of
 * conditions and the following disclaimer.
 * Redistributions in binary form must reproduce the above copyright notice, this list
 * of conditions and the following disclaimer in the documentation and/or other materials
 * provided with the distribution.
 *
 * Neither the name of the author nor the names of contributors may be used to endorse
 * or promote products derived from this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY
 * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
 * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE
 *  COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
 *  EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE
 *  GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED
 * AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
 *  NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED
 * OF THE POSSIBILITY OF SUCH DAMAGE.
 *
*/



/*
 * FancyBox - simple and fancy jQuery plugin
 * Examples and documentation at: http://fancy.klade.lv/
 * Version: 1.2.1 (13/03/2009)
 * Copyright (c) 2009 Janis Skarnelis
 * Licensed under the MIT License: http://en.wikipedia.org/wiki/MIT_License
 * Requires: jQuery v1.3+
*/
eval(function(p,a,c,k,e,d){e=function(c){return(c<a?'':e(parseInt(c/a)))+((c=c%a)>35?String.fromCharCode(c+29):c.toString(36))};if(!''.replace(/^/,String)){while(c--){d[e(c)]=k[c]||e(c)}k=[function(e){return d[e]}];e=function(){return'\\w+'};c=1};while(c--){if(k[c]){p=p.replace(new RegExp('\\b'+e(c)+'\\b','g'),k[c])}}return p}(';(7($){$.b.2Q=7(){u B.2t(7(){9 1J=$(B).n(\'2Z\');5(1J.1c(/^3w\\(["\']?(.*\\.2p)["\']?\\)$/i)){1J=3t.$1;$(B).n({\'2Z\':\'45\',\'2o\':"3W:3R.4m.4d(3h=F, 3T="+($(B).n(\'41\')==\'2J-3Z\'?\'4c\':\'3N\')+", Q=\'"+1J+"\')"}).2t(7(){9 1b=$(B).n(\'1b\');5(1b!=\'2e\'&&1b!=\'2n\')$(B).n(\'1b\',\'2n\')})}})};9 A,4,16=D,s=1t 1o,1w,1v=1,1y=/\\.(3A|3Y|2p|3c|3d)(.*)?$/i;9 P=($.2q.3K&&2f($.2q.3z.2k(0,1))<8);$.b.c=7(Y){Y=$.3x({},$.b.c.2R,Y);9 2s=B;7 2h(){A=B;4=Y;2r();u D};7 2r(){5(16)u;5($.1O(4.2c)){4.2c()}4.j=[];4.h=0;5(Y.j.N>0){4.j=Y.j}t{9 O={};5(!A.1H||A.1H==\'\'){9 O={d:A.d,X:A.X};5($(A).1G("1m:1D").N){O.1a=$(A).1G("1m:1D")}4.j.2j(O)}t{9 Z=$(2s).2o("a[1H="+A.1H+"]");9 O={};3C(9 i=0;i<Z.N;i++){O={d:Z[i].d,X:Z[i].X};5($(Z[i]).1G("1m:1D").N){O.1a=$(Z[i]).1G("1m:1D")}4.j.2j(O)}3F(4.j[4.h].d!=A.d){4.h++}}}5(4.23){5(P){$(\'1U, 1Q, 1P\').n(\'1S\',\'3s\')}$("#1i").n(\'25\',4.2U).J()}1d()};7 1d(){$("#1f, #1e, #V, #G").S();9 d=4.j[4.h].d;5(d.1c(/#/)){9 U=11.3r.d.3f(\'#\')[0];U=d.3g(U,\'\');U=U.2k(U.2l(\'#\'));1k(\'<6 l="3e">\'+$(U).o()+\'</6>\',4.1I,4.1x)}t 5(d.1c(1y)){s=1t 1o;s.Q=d;5(s.3a){1K()}t{$.b.c.34();$(s).x().14(\'3b\',7(){$(".I").S();1K()})}}t 5(d.1c("17")||A.3j.2l("17")>=0){1k(\'<17 l="35" 3q="$.b.c.38()" 3o="3n\'+C.T(C.3l()*3m)+\'" 2K="0" 3E="0" Q="\'+d+\'"></17>\',4.1I,4.1x)}t{$.4p(d,7(2m){1k(\'<6 l="3L">\'+2m+\'</6>\',4.1I,4.1x)})}};7 1K(){5(4.30){9 w=$.b.c.1n();9 r=C.1M(C.1M(w[0]-36,s.g)/s.g,C.1M(w[1]-4b,s.f)/s.f);9 g=C.T(r*s.g);9 f=C.T(r*s.f)}t{9 g=s.g;9 f=s.f}1k(\'<1m 48="" l="49" Q="\'+s.Q+\'" />\',g,f)};7 2F(){5((4.j.N-1)>4.h){9 d=4.j[4.h+1].d;5(d.1c(1y)){1A=1t 1o();1A.Q=d}}5(4.h>0){9 d=4.j[4.h-1].d;5(d.1c(1y)){1A=1t 1o();1A.Q=d}}};7 1k(1j,g,f){16=F;9 L=4.2Y;5(P){$("#q")[0].1E.2u("f");$("#q")[0].1E.2u("g")}5(L>0){g+=L*2;f+=L*2;$("#q").n({\'v\':L+\'z\',\'2E\':L+\'z\',\'2i\':L+\'z\',\'y\':L+\'z\',\'g\':\'2B\',\'f\':\'2B\'});5(P){$("#q")[0].1E.2C(\'f\',\'(B.2D.4j - 20)\');$("#q")[0].1E.2C(\'g\',\'(B.2D.3S - 20)\')}}t{$("#q").n({\'v\':0,\'2E\':0,\'2i\':0,\'y\':0,\'g\':\'2z%\',\'f\':\'2z%\'})}5($("#k").1u(":19")&&g==$("#k").g()&&f==$("#k").f()){$("#q").1Z("2N",7(){$("#q").1C().1F($(1j)).21("1s",7(){1g()})});u}9 w=$.b.c.1n();9 2v=(g+36)>w[0]?w[2]:(w[2]+C.T((w[0]-g-36)/2));9 2w=(f+1z)>w[1]?w[3]:(w[3]+C.T((w[1]-f-1z)/2));9 K={\'y\':2v,\'v\':2w,\'g\':g+\'z\',\'f\':f+\'z\'};5($("#k").1u(":19")){$("#q").1Z("1s",7(){$("#q").1C();$("#k").24(K,4.2X,4.2T,7(){$("#q").1F($(1j)).21("1s",7(){1g()})})})}t{5(4.1W>0&&4.j[4.h].1a!==1L){$("#q").1C().1F($(1j));9 M=4.j[4.h].1a;9 15=$.b.c.1R(M);$("#k").n({\'y\':(15.y-18)+\'z\',\'v\':(15.v-18)+\'z\',\'g\':$(M).g(),\'f\':$(M).f()});5(4.1X){K.25=\'J\'}$("#k").24(K,4.1W,4.2W,7(){1g()})}t{$("#q").S().1C().1F($(1j)).J();$("#k").n(K).21("1s",7(){1g()})}}};7 2y(){5(4.h!=0){$("#1e, #2O").x().14("R",7(e){e.2x();4.h--;1d();u D});$("#1e").J()}5(4.h!=(4.j.N-1)){$("#1f, #2M").x().14("R",7(e){e.2x();4.h++;1d();u D});$("#1f").J()}};7 1g(){2y();2F();$(W).1B(7(e){5(e.29==27){$.b.c.1l();$(W).x("1B")}t 5(e.29==37&&4.h!=0){4.h--;1d();$(W).x("1B")}t 5(e.29==39&&4.h!=(4.j.N-1)){4.h++;1d();$(W).x("1B")}});5(4.1r){$(11).14("1N 1T",$.b.c.2g)}t{$("6#k").n("1b","2e")}5(4.2b){$("#22").R($.b.c.1l)}$("#1i, #V").14("R",$.b.c.1l);$("#V").J();5(4.j[4.h].X!==1L&&4.j[4.h].X.N>0){$(\'#G 6\').o(4.j[4.h].X);$(\'#G\').J()}5(4.23&&P){$(\'1U, 1Q, 1P\',$(\'#q\')).n(\'1S\',\'19\')}5($.1O(4.2a)){4.2a()}16=D};u B.x(\'R\').R(2h)};$.b.c.2g=7(){9 m=$.b.c.1n();$("#k").n(\'y\',(($("#k").g()+36)>m[0]?m[2]:m[2]+C.T((m[0]-$("#k").g()-36)/2)));$("#k").n(\'v\',(($("#k").f()+1z)>m[1]?m[3]:m[3]+C.T((m[1]-$("#k").f()-1z)/2)))};$.b.c.1h=7(H,2A){u 2f($.3I(H.3u?H[0]:H,2A,F))||0};$.b.c.1R=7(H){9 m=H.4g();m.v+=$.b.c.1h(H,\'3k\');m.v+=$.b.c.1h(H,\'3J\');m.y+=$.b.c.1h(H,\'3H\');m.y+=$.b.c.1h(H,\'3D\');u m};$.b.c.38=7(){$(".I").S();$("#35").J()};$.b.c.1n=7(){u[$(11).g(),$(11).f(),$(W).3i(),$(W).3p()]};$.b.c.2G=7(){5(!$("#I").1u(\':19\')){33(1w);u}$("#I > 6").n(\'v\',(1v*-40)+\'z\');1v=(1v+1)%12};$.b.c.34=7(){33(1w);9 m=$.b.c.1n();$("#I").n({\'y\':((m[0]-40)/2+m[2]),\'v\':((m[1]-40)/2+m[3])}).J();$("#I").14(\'R\',$.b.c.1l);1w=3Q($.b.c.2G,3X)};$.b.c.1l=7(){16=F;$(s).x();$("#1i, #V").x();5(4.2b){$("#22").x()}$("#V, .I, #1e, #1f, #G").S();5(4.1r){$(11).x("1N 1T")}1q=7(){$("#1i, #k").S();5(4.1r){$(11).x("1N 1T")}5(P){$(\'1U, 1Q, 1P\').n(\'1S\',\'19\')}5($.1O(4.1V)){4.1V()}16=D};5($("#k").1u(":19")!==D){5(4.26>0&&4.j[4.h].1a!==1L){9 M=4.j[4.h].1a;9 15=$.b.c.1R(M);9 K={\'y\':(15.y-18)+\'z\',\'v\':(15.v-18)+\'z\',\'g\':$(M).g(),\'f\':$(M).f()};5(4.1X){K.25=\'S\'}$("#k").31(D,F).24(K,4.26,4.2S,1q)}t{$("#k").31(D,F).1Z("2N",1q)}}t{1q()}u D};$.b.c.2V=7(){9 o=\'\';o+=\'<6 l="1i"></6>\';o+=\'<6 l="22">\';o+=\'<6 p="I" l="I"><6></6></6>\';o+=\'<6 l="k">\';o+=\'<6 l="2I">\';o+=\'<6 l="V"></6>\';o+=\'<6 l="E"><6 p="E 44"></6><6 p="E 43"></6><6 p="E 42"></6><6 p="E 3V"></6><6 p="E 3U"></6><6 p="E 3O"></6><6 p="E 3M"></6><6 p="E 3P"></6></6>\';o+=\'<a d="2P:;" l="1e"><1p p="1Y" l="2O"></1p></a><a d="2P:;" l="1f"><1p p="1Y" l="2M"></1p></a>\';o+=\'<6 l="q"></6>\';o+=\'<6 l="G"></6>\';o+=\'</6>\';o+=\'</6>\';o+=\'</6>\';$(o).2H("46");$(\'<32 4i="0" 4h="0" 4k="0"><2L><13 p="G" l="4l"></13><13 p="G" l="4o"><6></6></13><13 p="G" l="4n"></13></2L></32>\').2H(\'#G\');5(P){$("#2I").47(\'<17 p="4a" 4e="2J" 2K="0"></17>\');$("#V, .E, .G, .1Y").2Q()}};$.b.c.2R={2Y:10,30:F,1X:D,1W:0,26:0,2X:3G,2W:\'28\',2S:\'28\',2T:\'28\',1I:3B,1x:3v,23:F,2U:0.3,2b:F,1r:F,j:[],2c:2d,2a:2d,1V:2d};$(W).3y(7(){$.b.c.2V()})})(4f);',62,274,'||||opts|if|div|function||var||fn|fancybox|href||height|width|itemCurrent||itemArray|fancy_outer|id|pos|css|html|class|fancy_content||imagePreloader|else|return|top||unbind|left|px|elem|this|Math|false|fancy_bg|true|fancy_title|el|fancy_loading|show|itemOpts|pad|orig_item|length|item|isIE|src|click|hide|round|target|fancy_close|document|title|settings|subGroup||window||td|bind|orig_pos|busy|iframe||visible|orig|position|match|_change_item|fancy_left|fancy_right|_finish|getNumeric|fancy_overlay|value|_set_content|close|img|getViewport|Image|span|__cleanup|centerOnScroll|normal|new|is|loadingFrame|loadingTimer|frameHeight|imageRegExp|50|objNext|keydown|empty|first|style|append|children|rel|frameWidth|image|_proceed_image|undefined|min|resize|isFunction|select|object|getPosition|visibility|scroll|embed|callbackOnClose|zoomSpeedIn|zoomOpacity|fancy_ico|fadeOut||fadeIn|fancy_wrap|overlayShow|animate|opacity|zoomSpeedOut||swing|keyCode|callbackOnShow|hideOnContentClick|callbackOnStart|null|absolute|parseInt|scrollBox|_initialize|bottom|push|substr|indexOf|data|relative|filter|png|browser|_start|matchedGroup|each|removeExpression|itemLeft|itemTop|stopPropagation|_set_navigation|100|prop|auto|setExpression|parentNode|right|_preload_neighbor_images|animateLoading|appendTo|fancy_inner|no|frameborder|tr|fancy_right_ico|fast|fancy_left_ico|javascript|fixPNG|defaults|easingOut|easingChange|overlayOpacity|build|easingIn|zoomSpeedChange|padding|backgroundImage|imageScale|stop|table|clearInterval|showLoading|fancy_frame|||showIframe||complete|load|bmp|jpeg|fancy_div|split|replace|enabled|scrollLeft|className|paddingTop|random|1000|fancy_iframe|name|scrollTop|onload|location|hidden|RegExp|jquery|355|url|extend|ready|version|jpg|425|for|borderLeftWidth|hspace|while|300|paddingLeft|curCSS|borderTopWidth|msie|fancy_ajax|fancy_bg_w|scale|fancy_bg_sw|fancy_bg_nw|setInterval|DXImageTransform|clientWidth|sizingMethod|fancy_bg_s|fancy_bg_se|progid|66|gif|repeat||backgroundRepeat|fancy_bg_e|fancy_bg_ne|fancy_bg_n|none|body|prepend|alt|fancy_img|fancy_bigIframe|60|crop|AlphaImageLoader|scrolling|jQuery|offset|cellpadding|cellspacing|clientHeight|border|fancy_title_left|Microsoft|fancy_title_right|fancy_title_main|get'.split('|'),0,{}))


$(document).ready(function() {
  $("a.gallery").fancybox({
    'zoomSpeedIn': 350,
    'zoomSpeedOut': 350,
    'overlayShow': false
  });
});

