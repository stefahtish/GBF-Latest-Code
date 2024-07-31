page 50959 "Target Dairy Products"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Laboratory Setup Type";
    SourceTableView = where(Type=const("Target Dairy Product"));

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                }
                field("Lab Section"; Rec."Lab Section")
                {
                }
            }
        }
        area(Factboxes)
        {
        }
    }
    actions
    {
        area(Processing)
        {
            action("Possible Tests")
            {
                Image = Process;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                RunObject = page "Possible Tests";
                RunPageLink = Product=field(Name);
            }
        }
    }
    trigger OnInsertRecord(BelowxRec: Boolean): Boolean begin
        Rec.Type:=Rec.Type::"Target Dairy Product";
    end;
}
