document.getElementById("radio-fixed").addEventListener("click", function(){
  document.getElementById("form-occurrence").style.display = "none";
  document.getElementById("form-fixed").style.display = "block";

});
document.getElementById("radio-occurrence").addEventListener("click", function(){
  document.getElementById("form-occurrence").style.display = "block";
  document.getElementById("form-fixed").style.display = "none";
})