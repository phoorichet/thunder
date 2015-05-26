'use strict';

(function(){
  
  var module = angular.module('shoppes.collection.controllers', [ 'shoppes.api.services', 
                                                                  'shoppes.collection.services']);

  module.controller('CollectionController', ['$scope', 'Api', 'Collection', '$filter', '$location', 
    function($scope, Api, Collection, $filter, $location){

    	// Initialize items from state resolve.
    	// $scope.items = items;

    	// Use service as a factory
    	$scope.collection = Collection.index();
    	
    }
  ]) // end module
}());