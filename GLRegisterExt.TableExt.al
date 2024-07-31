tableextension 50168 GLRegisterExt extends "G/L Register"
{
    fields
    {
        field(50000; "Document No."; Code[50])
        {
            CalcFormula = Lookup("G/L Entry"."Document No." WHERE("Entry No."=FIELD("From Entry No.")));
            Editable = false;
            FieldClass = FlowField;
        }
    }
}
