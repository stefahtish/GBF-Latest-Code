tableextension 50100 PaymentMethodExt extends "Payment Method"
{
    fields
    {
        field(100; Default; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(101; "Document Path"; Text[200])
        {
            DataClassification = ToBeClassified;
        }
    }
}
