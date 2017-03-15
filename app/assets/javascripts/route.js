var app = angular.module("app", []);
app.config([
    "$httpProvider",
    function($httpProvider) {
        $httpProvider.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content');
    }
]);
app.controller("controller", function($scope, $http) {
    $scope.countries = [];
    $scope.states = [];
    $scope.cities = [];
    $scope.names = [];
    $scope.country;
    $scope.state;
    $scope.city;
    $scope.GetSelectedCountry = function() {
        if ($scope.country) {
            $scope.states = $scope.country.States;
            $scope.state = '';
            $scope.cities = [];
        } else {
            $scope.states = [];
        }
    };
    $scope.GetSelectedState = function() {
        if ($scope.state) {
            $scope.cities = $scope.state.cities;
            $scope.city = '';
        } else {
            $scope.cities = [];
        }
    };
    //Local Database response
    //$scope.countries = gon.your_variable
    $scope.tierDataFromDB = [];
    $scope.programs = [];
    $scope.getTiersFromDB = function() {
        $http.get('/getTiers').then(function successCallback(response) {
            $scope.tierDataFromDB = response.data;
        }, function errorCallback(response) {
            //alert('failed');
        });
    };
    $scope.getSelectedTier = function() {
        if ($scope.selected_tier_db) {
            $http({
                url: '/getPrograms',
                method: 'POST',
                data: { 'tier': $scope.selected_tier_db.tier }
            }).then(function successCallback(response) {
                $scope.programs = response.data;
                console.log(response.data[0].programs);
            }, function errorCallback(response) {});
        } else {
            $scope.programs = [];
        }
    };





    // Rest Call response
    $scope.restData = [];
    $scope.programsDataFromRest = [];
    $scope.levelsDataFromRest = [];
    $scope.getDataFromRCXApp = function() {
        $http.get('rest/getTierSvc').then(function successCallback(response) {
            //   alert('success');
            $scope.restData = response.data;
            console.log('rest data: =  ' + JSON.stringify($scope.restData));
        }, function errorCallback(response) {
            //alert('failed');
        });
    };
    $scope.getSelectedTierFromRXCApp = function() {
        if ($scope.selected_tier) {
            $http({
                url: 'rest/getProgramsSvc?tier_id=' + $scope.selected_tier.tier_id,
                method: 'GET'
            }).then(function successCallback(response) {
                $scope.programsDataFromRest = response.data;
            }, function errorCallback(response) {
                //alert('failed...');
            });
            $scope.levelsDataFromRest = [];
        } else {
            $scope.programsDataFromRest = [];
        }
    };
    $scope.getSelectedProgramsFromRXCApp = function() {
        if ($scope.selected_program) {
            $http({
                url: 'rest/getLevelsSvc?program_id=' + $scope.selected_program.program_id,
                method: 'GET'
            }).then(function successCallback(response) {
                $scope.levelsDataFromRest = response.data;
            }, function errorCallback(response) {
                //alert('failed...');
            });
        } else {
            $scope.levelsDataFromRest = [];
        }
    };
    //$scope.countries = [{ "_id": 1, "name": "India", "States": [{ "id": 1, "name": "Maharashtra", "cities": ["Pune", "Mumbai", "Nagpur", "Akola"] }, { "id": 2, "name": "Madhya Pradesh", "cities": ["Indore", "Bhopal", "Jabalpur"] }, { "id": 3, "name": "Rajasthan", "cities": ["Jaipur", "Ajmer", "Jodhpur"] }] }, { "_id": 2, "name": "USA", "States": [{ "id": 1, "name": "Alabama", "cities": ["Montgomery", "Birmingham"] }, { "id": 2, "name": "California", "cities": ["Sacramento", "Fremont"] }, { "id": 3, "name": "Illinois", "cities": ["Springfield", "Chicago"] }] }, { "_id": 3, "name": "Australia", "States": [{ "id": 1, "name": "New South Wales", "cities": ["Sydney"] }, { "id": 2, "name": "Victoria", "cities": ["Melbourne"] }] }];
});