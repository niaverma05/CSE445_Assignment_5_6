using System;

namespace StudentHelperApp
{
    public static class SessionKeys
    {
        private const string StudyPlanEntriesBase = "StudyPlanEntries";
        private const string LastStudyRecommendationBase = "LastStudyRecommendation";

        public static string GetStudyPlanEntriesKey(string username)
        {
            if (string.IsNullOrWhiteSpace(username))
                return StudyPlanEntriesBase;

            return StudyPlanEntriesBase + ":" + username.Trim();
        }

        public static string GetLastStudyRecommendationKey(string username)
        {
            if (string.IsNullOrWhiteSpace(username))
                return LastStudyRecommendationBase;

            return LastStudyRecommendationBase + ":" + username.Trim();
        }
    }
}
