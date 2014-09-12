package com.zaxxer.hikari.json.obj;

import java.util.List;

public class MenuBar
{
   public Menu menu;

   public static class Menu
   {
      public String id;
      public String value;
      public Popup popup;
   }

   public static class Popup
   {
      public List<MenuItem> menuitem;
   }

   public static class MenuItem
   {
      public String value;
      public String onclick;
   }
}
