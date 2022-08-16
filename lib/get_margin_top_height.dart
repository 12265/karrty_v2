double getMarginTopHeight (int length)
{
  if(length ==1)
    {
      return 650;
    }
  else if(length == 2)
    {
      return 500;
    }
  else if (length == 3)
    {
      return 360;
    }
  else
    {
      print("LQSS");
      return 250;
    }
}