page 50993 "Contract Amount"
{
    PageType = ListPart;
    SourceTable = "Cert_Contract Amount";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Conract No."; Rec."Conract No.")
                {
                    Visible = false;

                    trigger OnValidate()
                    begin
                        Contract.Reset;
                        Contract.SetRange("Contract No.", Rec."Conract No.");
                        if Contract.Find('-') then Rec."Contract Amount" := Contract."Original Contract Price";
                        Rec."Consoltancy Fee" := Contract."Contract Value";
                        Rec."Provisional Sum" := Abs(Rec."Contract Amount" - Rec."Consoltancy Fee");
                    end;
                }
                field("Contract Amount"; Rec."Contract Amount")
                {
                }
                field("Consoltancy Fee"; Rec."Consoltancy Fee")
                {
                }
                field("Provisional Sum"; Rec."Provisional Sum")
                {
                }
            }
        }
    }
    actions
    {
    }
    var
        Contract: Record Contract1;
}
