xmlport 50108 "Import Deduction Balances"
{
    Direction = Import;
    Format = VariableText;
    FormatEvaluate = Legacy;

    schema
    {
    textelement(Root)
    {
    tableelement("Deduction Balances";
    "Deduction Balances")
    {
    XmlName = 'Earn_Ded';

    fieldelement(Employee_No;
    "Deduction Balances"."Employee No")
    {
    }
    fieldelement(Deduction_Code;
    "Deduction Balances"."Deduction Code")
    {
    FieldValidate = no;
    }
    fieldelement(Date;
    "Deduction Balances".Date)
    {
    }
    fieldelement(Amount;
    "Deduction Balances".Amount)
    {
    }
    }
    }
    }
    requestpage
    {
        layout
        {
        }
        actions
        {
        }
    }
    var Employee: Record Employee;
    No: Code[20];
    "Earn&DedHead": Record "Import Earn & Ded Header";
}
