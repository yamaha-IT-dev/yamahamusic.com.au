<table cellpadding="0" cellspacing="0" align="center" class="main_header_table" border="0">
  <tr>
    <td align="left" ><table width="100%" cellpadding="0" cellspacing="0" border="0">
        <tr>
          <td align="left"><a href="./"><img src="../images/yamaha.jpg" border="0" /></a>
          <br><div style="color:white">G'day <%= session("user_firstname") %> (<%= session("yma_userid") %>)! (<a href="../?logout=y" style="color:white">Logout</a>)</div>
          </td>
          <td width="4%" align="center"><a href="http://www.instagram.com/yamahabackstage/" target="_blank"><img src="../images/icon_instagram.png" name="btn_instagram" border="0" id="btn_instagram" /></a></td>
          <td width="4%" align="center"><a href="http://www.pinterest.com/yamahaaustralia/" target="_blank"><img src="../images/icon_pinterest.jpg" name="btn_pinterest" border="0" id="btn_pinterest" /></a></td>
          <td width="4%" align="center"><a href="http://www.youtube.com/yamahaaustralia" target="_blank"><img src="../images/icon_youtube.jpg" name="btn_youtube" border="0" id="btn_youtube" /></a></td>
          <td width="4%" align="center"><a href="http://www.twitter.com/YamahaBackstage" target="_blank"><img src="../images/icon_twitter.jpg" name="btn_twitter" border="0" id="btn_twitter" /></a></td>
          <td width="4%" align="center"><a href="http://www.facebook.com/Yamahabackstagepass" target="_blank"><img src="../images/icon_facebook.jpg" name="btn_facebook" border="0" id="btn_facebook" /></a></td>
          <td width="12%" align="center"><a href="http://www.yamahabackstage.com.au/" target="_blank"><img src="../images/logo_backstage.png" border="0" /></a></td>
        </tr>
      </table></td>
  </tr>
  <tr>
    <td><table width="100%" class="main_table" cellpadding="20" cellspacing="0">
        <tr>
          <% if strSection = "home" then %>
          <td class="menu_item_current">Home</td>
          <% else %>
          <td class="menu_item"><a href="home.asp" class="menu">Home</a></td>
          <% end if %>
          <% if strSection = "marketing" then %>
          <td class="menu_item_current">Marketing</td>
          <% else %>
          <td class="menu_item"><a href="marketing.asp" class="menu">Marketing</a></td>
          <% end if %>
          <% if strSection = "booking" then %>
          <td class="menu_item_current">Booking</td>
          <% else %>
          <td class="menu_item"><a href="bookings.asp" class="menu">Booking</a></td>
          <% end if %>
          <% if strSection = "stock" then %>
          <td class="menu_item_current">Stock</td>
          <% else %>
          <td class="menu_item"><a href="stock.asp" class="menu">Stock</a></td>
          <% end if %>
          <% if strSection = "order" then %>
          <td class="menu_item_current">Order</td>
          <% else %>
          <td class="menu_item"><a href="orders.asp" class="menu">Order</a></td>
          <% end if %>
          <% if strSection = "artwork" then %>
          <td class="menu_item_current">Artwork</td>
          <% else %>
          <td class="menu_item"><a href="artworks.asp" class="menu">Artwork</a></td>
          <% end if %>
          <% if strSection = "returns" then %>
          <td class="menu_item_current">Return</td>
          <% else %>
          <td class="menu_item"><a href="return.asp" class="menu">Return</a></td>
          <% end if %>          
          <% if strSection = "product" then %>
          <td class="menu_item_current">Product</td>
          <% else %>
          <td class="menu_item"><a href="product.asp" class="menu">Product</a></td>
          <% end if %>
          <% if strSection = "coop" then %>
          <td class="menu_item_current">Co-op</td>
          <% else %>
          <td class="menu_item"><a href="coop.asp" class="menu">Co-op</a></td>
          <% end if %>
          <% if strSection = "contact" then %>
          <td class="menu_item_current">Contact</td>
          <% else %>
          <td class="menu_item"><a href="contact-us.asp" class="menu">Contact</a></td>
          <% end if %>
          <% if strSection = "profile" then %>
          <td class="menu_item_current">Profile</td>
          <% else %>
          <td class="menu_item"><a href="profile.asp" class="menu">Profile</a></td>
          <% end if %>
        </tr>
      </table></td>
  </tr>
</table>
