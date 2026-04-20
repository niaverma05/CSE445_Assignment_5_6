using System.ServiceModel;

namespace UnitConverterService
{
    [ServiceContract(Namespace = "http://studenthelperapp.local/")]
    public interface IUnitConverterService
    {
        // Converts a numeric value from one unit to another.
        [OperationContract]
        double ConvertUnits(double value, string fromUnit, string toUnit);

        // Returns a comma-separated list of all supported unit tokens (e.g. "miles,km,lbs,kg,f,c").
        [OperationContract]
        string GetSupportedUnits();

        // Simple health-check.
        [OperationContract]
        string HealthCheck();
    }
}
