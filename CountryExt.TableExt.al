tableextension 50154 CountryExt extends "Country/Region"
{
    fields
    {
        field(50000; Nationailty; Text[70])
        {
            DataClassification = ToBeClassified;
        }
        field(50001; Local; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }
}
