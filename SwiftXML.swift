//
//  GenericXmlParserDelegate.swift
//
//  Created by Andrew Theken on 1/8/15.
//  Copyright (c) 2015 Andrew Theken.
//  Licensed under the terms of the MIT License.
//

import Foundation

class GenericXmlParserDelegate : NSObject, NSXMLParserDelegate {

    var rootElement:XmlNode? = nil;
    var currentElement:XmlNode? = nil;
    
    func parser(parser: NSXMLParser!, didEndElement elementName: String!, namespaceURI: String!, qualifiedName qName: String!) {
        
        if(currentElement?.parent != nil){
            currentElement = currentElement?.parent;
        }
    }
    
    func parser(parser: NSXMLParser!, didStartElement elementName: String!, namespaceURI: String!, qualifiedName qName: String!, attributes attributeDict: [NSObject : AnyObject]!) {

        if(rootElement == nil){
            rootElement = XmlNode();
            currentElement = rootElement;
        }else{
            var element = currentElement!;
            var newElement = XmlNode();
            newElement.parent = element;
            element.nodes.append(newElement);
            currentElement = newElement;
        }
        
        currentElement?.name = elementName;

        for (var name,value) in attributeDict{
            currentElement?.attributes[name as String] = value as? String;
        }
    }
    
    func parser(parser: NSXMLParser!, foundCharacters string: String!) {
        currentElement?.content += string;
    }
}

class XmlNode {
    var attributes:Dictionary<String,String> = Dictionary<String,String>();
    var parent:XmlNode? = nil;

    var name:String = "";
    var content:String = "";
    var nodes:[XmlNode] = [];

    //TODO: Add XPath searching.
}
