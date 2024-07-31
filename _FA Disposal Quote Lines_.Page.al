page 50236 "FA Disposal Quote Lines"
{
    PageType = ListPart;
    SourceTable = "Procurement Request Lines";
    InsertAllowed = false;
    DeleteAllowed = false;
    DelayedInsert = false;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Type; Rec.Type)
                {
                }
                field(No; Rec.No)
                {
                }
                field(Description; Rec.Description)
                {
                }
                field(Quantity; Rec.Quantity)
                {
                }
                field("Unit Price"; Rec."Unit Price")
                {
                }
                field(Amount; Rec.Amount)
                {
                }
            }
        }
    }
    actions
    {
    }
    trigger OnAfterGetRecord()
    var
        myInt: Integer;
    begin
    end;

    var
        InStrm: InStream;
        OutStrm: OutStream;
        SpecificationBigTxt: BigText;
        SpecificationTxt: Text;
}
