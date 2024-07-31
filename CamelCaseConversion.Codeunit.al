codeunit 50149 CamelCaseConversion
{
    procedure ConvertToCamelCase(var Text: Text)
    var
        i: Integer;
        IsSpace: Boolean;
        TextBuilder: TextBuilder;
    begin
        TextBuilder:=TextBuilder;
        IsSpace:=false;
        for i:=1 to StrLen(Text)do begin
            if IsSpace then begin
                TextBuilder.Append(Format(Text[i], i));
                IsSpace:=false;
            end
            else if Text[i] = ' ' then begin
                    IsSpace:=true;
                end
                else
                begin
                    TextBuilder.Append(Format(Text[i], i));
                end;
        end;
        Text:=TextBuilder.ToText;
    end;
// trigger OnAfterModifyRecord(var Rec: Record)
// begin
//     if Rec.TestField1.IsText then
//         ConvertToCamelCase(Rec.TestField1);
//     if Rec.TestField2.IsText then
//         ConvertToCamelCase(Rec.TestField2);
//     // Add more fields as needed
// end;
}
