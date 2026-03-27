const baseUrl = "https://betazone.promaticstechnologies.com/fs-api/";
const mediaBaseUrl = "https://passo-prom.s3.ap-south-1.amazonaws.com/freestyle";
const headerKey = "Authorization";

const createAccountUrl = "user/signup";
const createAccountReq = 1;

const loginUrl = "user/login";
const loginReq = 2;

const forgotPasswordUrl = "user/forgotpassword";
const forgotPasswordReq = 3;

const verifyOtpUrl = "user/verify";
const verifyOtpReq = 4;

const resendOtpUrl = "user/refreshotp";
const resendOtpReq = 5;

const resetPasswordUrl = "user/resetpassword";
const resetPasswordReq = 6;

const getProfileUrl = "user/profile";
const getProfileReq = 7;

const cmsApiUrl = "admin/getpolicy";
const cmsApiReq = 8;

const getFaqsUrl = "user/getfaqs";
const getFaqsReq = 9;

const changePasswordUrl = "user/changepassword";
const changePasswordReq = 10;

const contactUsUrl = "user/contactus";
const contactUsReq = 11;

const availableUsernameUrl = "user/avaliableusernames";
const availableUsernameReq = 12;

const profileCosmeticsUrl = "user/profilecosmetics";
const profileCosmeticsReq = 13;

const profileSetupUrl = "user/profilesetup";
const profileSetupReq = 14;

const emailMobileVerifyUrl = "user/updateidentifier";
const emailMobileVerifyReq = 15;

const fetchShopUrl = "user/fetchshop";
const fetchShopReq = 16;

const setUpPasswordUrl = "user/setuppassword";
const setUpPasswordReq = 17;

const buyProductUrl = "user/purchaseItem/";
const buyProductReq = 18;

const fetchInventoryUrl = "user/fetchInventory";
const fetchInventoryReq = 19;

const equipItemUrl = "user/setprofilecosmetics";
const equipItemReq = 20;

const getPlayersListingUrl = "user/players";
const getPlayersListingReq = 21;

const getOtherPlayerProfileUrl = "user/players";
const getOtherPlayerProfileReq = 22;

const getFriendListUrl = "user/socials";
const getFriendListReq = 23;

const followUrl = "user/sendrequest";
const followReq = 24;

const unFollowUrl = "user/unfriend";
const unFollowReq = 25;

const cancelSentReqUrl = "user/cancelsendrequest";
const cancelSentReqReq = 26;

const acceptRequestUrl = "user/acceptrequest";
const acceptRequestReq = 27;

const cancelReceivedReqUrl = "user/cancelreceivedrequest";
const cancelReceivedReqReq = 28;

const getBranchesUrl = "user/fetchbranches";
const getBranchesReq = 29;

const getTiersUrl = "user/fetchtiers";
const getTiersReq = 30;

const getSkillsUrl = "user/fetchskills";
const getSkillsReq = 31;

const getTutorialsListUrl = "user/fetchtutorials/";
const getTutorialsListReq = 32;

const getTutorialDetailsUrl = "user/fetchtutorial/";
const getTutorialDetailsReq = 33;

const uploadVideoUrl = "user/uploadmp4";
const uploadVideoReq = 34;

const submitSkillUrl = "user/submitskill";
const submitSkillReq = 35;

const unlockSkillUrl = "user/unlockaskill/";
const unlockSkillReq = 36;

const getSkillDetailsUrl = "user/fetchskilldetails/";
const getSkillDetailsReq = 37;

const getDailyChallengeUrl = "user/dashboard";
const getDailyChallengeReq = 38;

const dailyChallengeDetailsUrl = "user/challenge/";
const dailyChallengeDetailsReq = 39;

const submitDailyChallengeUrl = "user/submit-challenge";
const submitDailyChallengeReq = 40;

const dailyChallengeHistoryListUrl = "user/challenge-submissions";
const dailyChallengeHistoryListReq = 41;

const battlesListUrl = "user/fetchbattles";
const battlesListReq = 42;

const battleDetailsUrl = "user/battledetail/";
const battleDetailsReq = 43;

const createBattleUrl = "user/createbattle";
const createBattleReq = 44;

const battleSubmissionUrl = "user/battlesubmission";
const battleSubmissionReq = 45;

const battleHistoryUrl = "user/battlehistory";
const battleHistoryReq = 46;

const acceptBattleRequestUrl = "user/acceptbattleinvite/";
const acceptBattleRequestReq = 47;

const addFcmUrl = "user/add-fcm";
const addFcmReq = 48;

const removeFcmUrl = "user/remove-fcm";
const removeFcmReq = 49;

const notificationListUrl = "user/notifications";
const notificationListReq = 50;

const cancelBattleInviteUrl = "user/cancelbattleinvite/";
const cancelBattleInviteReq = 51;

const ongoingBattleUrl = "user/fetchongoingbattle/";
const ongoingBattleReq = 52;

const myTutorialsUrl = "user/listtutorials";
const myTutorialsReq = 53;

const globalLeaderBoardListUrl = "user/leaderboard/global";
const globalLeaderBoardListReq = 54;

const leagueListUrl = "user/leagues";
const leagueListReq = 55;

const createRoomApiUrl = "user/create-room";
const createRoomApiReq = 56;

const sendNotificationUrl = "user/chat-notification";
const sendNotificationReq = 57;

const adminDetailsUrl = "user/admin/details";
const adminDetailsReq = 58;
