tableextension 50100 PaymentMethodExt extends "Payment Method"
{
    fields
    {
        field(50100; Default; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(52101; "Document Path"; Text[200])
        {
            DataClassification = ToBeClassified;
        }
    }
}
