page 50281 "Apportionment Allocation Lines"
{
    PageType = ListPart;
    SourceTable = "Apportionment Allocation";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Company; Rec.Company)
                {
                }
                field(Type; Rec.Type)
                {
                    trigger OnValidate()
                    begin
                        CurrPage.Update;
                    end;
                }
                field(Amount; Rec.Amount)
                {
                    Editable = Rec."Type" = Rec."Type"::"Amount";
                    ShowCaption = false;
                    Visible = Rec."Type" = Rec."Type"::"Amount";
                }
                field(Allocation; Rec.Allocation)
                {
                }
            }
        }
    }
    actions
    {
    }
}
