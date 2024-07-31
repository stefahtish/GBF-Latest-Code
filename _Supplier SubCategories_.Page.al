page 50360 "Supplier SubCategories"
{
    Caption = 'Supply SubCodes';
    PageType = List;
    SourceTable = "Supplier Sub Category2";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Category Code"; Rec."Category Code")
                {
                    Visible = false;
                }
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("No. Requisitions"; Rec."No. Requisitions")
                {
                    ApplicationArea = All;
                    Enabled = false;
                }
            }
        }
    }
    actions
    {
        area(Reporting)
        {
            action("Purchase Requisitions for Subcode")
            {
                Ellipsis = true;
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    SubCateg: Record "Internal Request Header";
                begin
                    SubCateg.Reset;
                    SubCateg.SetRange(SubCateg."Supplier Subcategory", Rec.Code);
                    if SubCateg.FindFirst then begin
                        REPORT.Run(Report::"Purchase Request Subcategory", true, false, SubCateg)
                    end;
                end;
            }
        }
    }
    trigger OnAfterGetCurrRecord()
    begin
        Rec.CalcFields("No. Requisitions");
    end;
}
