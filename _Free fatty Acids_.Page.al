page 51072 "Free fatty Acids"
{
    AutoSplitKey = true;
    Caption = 'Free fatty Acids';
    PageType = ListPart;
    SourceTable = "Sample Test";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Titer (ml)"; Rec."Titer (ml)")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        myInt: Integer;
                    begin
                        if Rec."Titer (ml)" <> 0 then begin
                            Rec."Constant (0.282)" := 0.282;
                            Rec.Results := format(Rec."Titer (ml)" * Rec."Constant (0.282)");
                        end;
                    end;
                }
                field("Constant (0.282)"; Rec."Constant (0.282)")
                {
                    ApplicationArea = All;
                }
                field(Results; Rec.Results)
                {
                    Caption = 'Free fatty acid content in %(titer x 0.282)';
                    ApplicationArea = All;
                }
                field(Specifications; Rec.Specifications)
                {
                    ApplicationArea = All;
                }
                field("Remarks(PassFail)"; Rec."Remarks(PassFail)")
                {
                    ApplicationArea = All;
                }
                field("Cannot be done"; Rec."Cannot be done")
                {
                    ApplicationArea = All;
                }
                field(Comment; Rec.Comment)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
