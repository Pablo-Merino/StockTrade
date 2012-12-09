// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require peity.min
//= require accounting.min


$(function() {

	$('.chart span').peity('line', { height: 200, width:450});	
	$('.company_close_chart span').peity('line', { height: 200, width:530, min: $('.company_close_chart span').data('min')});
	$('.portfolio_chart span').peity('line', { height: 50, width:200, min: $('.porftolio_chart span').data('min')});

	updateShareTotalCost();
	portfolioShareCost();
	$('#share_amount').on('change keyup', function() {
		if($('#share_amount').attr('value') > 0)
			updateShareTotalCost();
	});


	function updateShareTotalCost() {
		$('.cost_estimation p.estimation').text(parseInt($('#share_amount').attr('value')));
		if(parseInt($('#share_amount').attr('value')) == 1) {
			$('.cost_estimation p.estimation').append(" share");
		} else {
			$('.cost_estimation p.estimation').append(" shares");
		}
			

		$('.cost_estimation p.estimation').append(" would cost you "+accounting.formatMoney(parseInt($('#share_amount').attr('value')) * parseInt($('div.cost_estimation').data('share_cost'))/100));


	}

	function portfolioShareCost() {
		$('.company_list').children().each(function () {

			$('.win_estimation p.estimation', this).append(" would get you "+accounting.formatMoney(parseInt($('#share_amount', this).attr('value')) * parseInt($('div.cost_estimation', this).data('share_cost'))/100));

			$('.win_estimation p.estimation', this).text(parseInt($('#share_amount', this).attr('value')));
			if(parseInt($('#share_amount', this).attr('value')) == 1) {
				$('.win_estimation p.estimation', this).append(" share");
			} else {
				$('.win_estimation p.estimation', this).append(" shares");
			}
				
			$('.win_estimation p.estimation', this).append(" would get you "+accounting.formatMoney(parseInt($('#share_amount', this).attr('value')) * parseInt($('div.win_estimation', this).data('share_cost'))/100));
		});
	}


});



