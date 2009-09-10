// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

//Event.addBehavior({ 'div.pagination a' : Remote.Link });
function myspace(url){
	var win = new Window({className: "spread", title: "Myspace", top:70, left:100, width:800, height:600, 
	url: url, showEffectOptions: {duration:1.5}}); win.show(); 
}

function alpha(e) {
     var k;
     document.all ? k = e.keyCode : k = e.which;
     return ((k > 64 && k < 91) || (k > 96 && k < 123) || k == 8);
}

function alphaNumbers(e) {
     var k;

     document.all ? k = e.keyCode : k = e.which;
//alert(k)
     return ((k > 64 && k < 91) || (k > 96 && k < 123) || k == 8|| k == 95|| k == 45 || (k > 48 && k < 57));
}

function numbersonly(e){
  var unicode=e.charCode? e.charCode : e.keyCode
 // alert("KeyCode: "+unicode)
  if (unicode!=8 && unicode!=9 && unicode!=16 && unicode!=17 && unicode!=35 && unicode!=36 && unicode!=37 && unicode!=39 && unicode!=46 && unicode!=114 && unicode!=116 && unicode!=190 && unicode!=63232 && unicode!=63233 && unicode!=63234 && unicode!=63235 && unicode!=46 && unicode!=63272) { //allow all these keys: 8=backspace; 9=tab; 16=shift; 17=ctrl; 35=end; 36=home; 37=left; 39=right; 190=period; 63232+=safari-arrowkeys;
    if (unicode<48||unicode>57) //if not a number
      return false //disable key press
  }
}

function check_should_update_address(){
	var elems=$('user_form').elements
	if (
		elems['user[address_attributes]__street_1'].value != elems['user[address_attributes]__old_street_1'].value ||
		elems['user[address_attributes]__street_2'].value != elems['user[address_attributes]__old_street_2'].value ||
		elems['user[address_attributes]__zip'].value != elems['user[address_attributes]__old_zip'].value ||
		elems['user[address_attributes]__city'].value != elems['user[address_attributes]__old_city'].value ||
		elems['user[address_attributes]__state'].value != elems['user[address_attributes]__old_state'].value ||
		elems['user[address_attributes]__country_code'].value != elems['user[address_attributes]__old_country_code'].value 
	){
		elems['user[address_attributes]__should_update'].value='1';
		//alert ('updated !')
	}
	//alert(elems['user[address_attributes]__street_1'].value)
	
	
	
	//alert(elems['user_street_1'].value)
//	alert($('user_street_1').value)
	return false;
	
}

	var updateStrength = function(pw) {
		var strength = getStrength(pw);
		var width = (100/32)*strength;
		new Effect.Morph('psStrength', {style:'width:'+width+'px', duration:'0.4'}); 
	}

	var getStrength = function(passwd) {
		intScore = 0;
		if (passwd.match(/[a-z]/)) // [verified] at least one lower case letter
				{
				intScore = (intScore+2)
				} if (passwd.match(/[A-Z]/)) // [verified] at least one upper case letter
				{
				intScore = (intScore+6)
				} // NUMBERS
				if (passwd.match(/\d+/)) // [verified] at least one number
				{
				intScore = (intScore+6)
				} if (passwd.match(/(\d.*\d.*\d)/)) // [verified] at least three numbers
				{
				intScore = (intScore+6)
				} // SPECIAL CHAR
				if (passwd.match(/[!,@#$%^&*?_~]/)) // [verified] at least one special character
				{
				intScore = (intScore+6)
				} if (passwd.match(/([!,@#$%^&*?_~].*[!,@#$%^&*?_~])/)) // [verified] at least two special characters
				{
				intScore = (intScore+6)
				} // COMBOS
				if (passwd.match(/[a-z]/) && passwd.match(/[A-Z]/)) // [verified] both upper and lower case
				{
				intScore = (intScore+2)
				} if (passwd.match(/\d/) && passwd.match(/\D/)) // [verified] both letters and numbers
				{
				intScore = (intScore+2)
				} // [Verified] Upper Letters, Lower Letters, numbers and special characters
				if (passwd.match(/[a-z]/) && passwd.match(/[A-Z]/) && passwd.match(/\d/) && passwd.match(/[!,@#$%^&*?_~]/))
				{
				intScore = (intScore+2)
				}
				if (intScore>32)intScore=32
				return intScore;
	}

/* fade flashes automatically 
Event.observe(window, 'load', function() { 
  $A(document.getElementsByClassName('alert')).each(function(o) {
    o.opacity = 100.0
    Effect.Fade(o, {duration: 3.5})
  });
});*/