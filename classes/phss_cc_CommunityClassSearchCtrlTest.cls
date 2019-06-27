/**
 * Created by jbarker on 10/23/18.
 */

@isTest
public with sharing class phss_cc_CommunityClassSearchCtrlTest {

    public static Account testAccount;
    public static Map<String, Object> testData;
    public static Opportunity testOpportunity;
    public static ccrz__E_Product__c testProduct;
    public static Geo_Location__c testLocation;


    /**
     * @description Set up for tests
     */
    public static void setup() {

        testData = phss_cc_TestDataFactory.setupAccountAndProducts();
        testAccount = (Account) testData.get(phss_cc_TestDataFactory.TEST_ACCOUNT);
        testOpportunity = phss_cc_TestDataFactory.createInsertTestOpportunity(testAccount);
        testLocation = phss_cc_TestDataFactory.createInsertTestGeoLocation();

        Map<String, Object> learningData = phss_cc_TestDataFactory.createInsertTestLearningObjects();
        redwing__Training_Plan__c trainingPlan = (redwing__Training_Plan__c) learningData.get(phss_cc_TestDataFactory.TEST_TRAINING_PLAN);

        List<ccrz__E_Product__c> testProducts = (List<ccrz__E_Product__c>) testData.get(phss_cc_TestDataFactory.TEST_PRODUCTS);
        testProduct = testProducts[0];
        testProduct.ccrz__InventoryType__c = 'COMMUNITY';
        testProduct.LMS_Learning_Plan__c = trainingPlan.Id;
        update testProduct;
    }

    /**
     * @description Formats a Date as a Javascript date string
     *
     * @param d
     *
     * @return
     */
    private static String formatDateAsYYYYMMDD(Date d) {
        String dateStr;

        if (d != null) {
            dateStr = '' + d.year() + '-' + d.month() + '-' + d.day();
        }

        return dateStr;
    }

    /**
     * @description Tests community class search by city and state
     */
    @isTest static void testClassSearch() {

        setup();

        String testSearchTerm = testProduct.Name;
        String testOpportunityId = testOpportunity.Id;
        String testStartDate = formatDateAsYYYYMMDD(phss_cc_TestDataFactory.TEST_COMMUNITY_CLASS_SEARCH_START_DATE);
        String testEndDate = formatDateAsYYYYMMDD(phss_cc_TestDataFactory.TEST_COMMUNITY_CLASS_SEARCH_END_DATE);
        String testCity = phss_cc_TestDataFactory.TEST_COMMUNITY_CLASS_SEARCH_CITY;
        String testState= phss_cc_TestDataFactory.TEST_COMMUNITY_CLASS_SEARCH_STATE;
        Integer testRange = phss_cc_TestDataFactory.TEST_COMMUNITY_CLASS_SEARCH_RANGE;

        Test.startTest();
        Map<String, Object> result = phss_cc_CommunityClassSearchController.classSearch(testSearchTerm, testOpportunityId, testStartDate, testEndDate, testCity, testState, null, testRange);
        Test.stopTest();

        System.assert(result != null);
    }
}