document.getElementById("calendar-entry-month").addEventListener("change", function(value,a ,bv){
  document.getElementById("calendar-entry-day").max = new Date(2000, value.target.selectedIndex + 1, 0).getDate();
})